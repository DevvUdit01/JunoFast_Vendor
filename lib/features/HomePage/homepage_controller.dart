import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/model.dart';

class HomePageController extends GetxController {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var leads = <Lead>[].obs;
  final String vendorId = 'UDtTGLIHgdTQQFtTwXow'; // Replace with actual vendor ID

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    fetchAndListenForLeads();
    _checkAndUpdateVendorLocation();
    _requestNotificationPermission();

    // Fetch and store the FCM token
    _firebaseMessaging.getToken().then((token) async {
      DocumentSnapshot vendorDoc = await _firestore.collection('vendors').doc(vendorId).get();
      var existingToken = vendorDoc['fcmToken'];
      if (existingToken != token) {
        await _firestore.collection('vendors').doc(vendorId).update({'fcmToken': token});
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage received: ${message.data}");
      if (message.notification != null) {
        _showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp received: ${message.data}");
      _handleNotificationClick(message);
    });
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        _handleNotificationClick(RemoteMessage(data: {'leadId': notificationResponse.payload}));
      },
    );
  }

  void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // channel ID
      'High Importance Notifications', // channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.notification?.title ?? 'New Lead Available',
      message.notification?.body ?? 'Tap to view details',
      platformChannelSpecifics,
      payload: message.data['leadId'], // Pass leadId or relevant data
    );
  }

  void _handleNotificationClick(RemoteMessage message) {
    print('onMessage received: ${message.data}');
  
    // Extract the leadId from the notification data
    String? leadId = message.data['leadId'];
  
    if (leadId != null && leadId.isNotEmpty) {
      print('Navigating to Lead ID: $leadId');
      
      // Perform navigation to the lead details page
      Get.toNamed('/lead-details', arguments: leadId);
    } else {
      print('Error: leadId is null or empty');
      Get.snackbar('Error', 'Invalid lead ID', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void fetchAndListenForLeads() {
    print('Fetching and listening for leads for vendor ID: $vendorId');
    _firestore.collection('leads').where('notifiedVendors', arrayContains: vendorId).snapshots().listen((querySnapshot) {
      print('Number of leads fetched: ${querySnapshot.docs.length}');
      leads.value = querySnapshot.docs.map((doc) => Lead.fromDocument(doc)).toList();
    }, onError: (error) {
      print('Error fetching leads: $error');
    });
  }

Future<void> acceptLead(String leadId) async {
  print('Attempting to accept lead with ID: $leadId');
  try {
    DocumentSnapshot leadDoc = await _firestore.collection('leads').doc(leadId).get();
    if (!leadDoc.exists) {
      Get.snackbar('Error', 'Lead not found', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return;
    }

    // Update lead document to indicate it has been accepted by the vendor
    await _firestore.collection('leads').doc(leadId).update({
      'acceptedBy': vendorId,
      'status': 'accepted',
    });

    // Fetch lead data after updating
    DocumentSnapshot leadDocAfterUpdate = await _firestore.collection('leads').doc(leadId).get();
    Map<String, dynamic>? leadData = leadDocAfterUpdate.data() as Map<String, dynamic>?;

    if (leadData != null) {
      // Add vendorId to the lead data
      leadData['acceptedBy'] = vendorId;

      // Move lead to bookings collection
      await _firestore.collection('bookings').doc(leadId).set(leadData);

      // Delete the lead from leads collection
      await _firestore.collection('leads').doc(leadId).delete();
      print('Lead moved to bookings and deleted from leads.');

      Get.snackbar('Success', 'Lead accepted and moved to bookings!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed to fetch lead data', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to accept lead: $e', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    print('Error: $e');
  }
}


  Future<void> _checkAndUpdateVendorLocation() async {
    final status = await Permission.location.status;
    if (!status.isGranted) {
      if (await Permission.location.request().isGranted) {
        // Permission granted
        await _updateVendorLocation();
      } 
    if (await Permission.location.isPermanentlyDenied) {
    // Show a dialog or snackbar asking the user to enable location in settings
      Get.snackbar('Location Permission', 'Please enable location permission in settings.', snackPosition: SnackPosition.BOTTOM);
      }

      else {
        // Handle the case when permission is denied
        print('Location permission is required to update vendor location.');
      }
    } else {
      // Permission already granted
      await _updateVendorLocation();
    }
  }

  Future<void> _updateVendorLocation() async {
    try {
      DocumentSnapshot vendorDoc = await _firestore.collection('vendors').doc(vendorId).get();
      var data = vendorDoc.data() as Map<String, dynamic>?;

      if (data == null || !data.containsKey('location') || data['location'] is! GeoPoint) {
        print('Vendor location is missing or not formatted as GeoPoint. Updating with current location.');

        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        GeoPoint updatedLocation = GeoPoint(position.latitude, position.longitude);

        await _firestore.collection('vendors').doc(vendorId).update({'location': updatedLocation});
        print('Vendor location updated successfully.');
      } else {
        GeoPoint location = data['location'] as GeoPoint;
        print('Vendor location is valid: ${location.latitude}, ${location.longitude}');
      }
    } catch (e) {
      print('Error updating vendor location: $e');
    }
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      print("Notification permission granted.");
    } else {
      final status = await Permission.notification.request();
      if (status.isGranted) {
        print("Notification permission granted after request.");
      } else {
        print("Notification permission denied.");
      }
    }
  }
}