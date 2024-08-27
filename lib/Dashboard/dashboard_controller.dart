import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardController extends GetxController {
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

    // Fetch and store the FCM token
    _firebaseMessaging.getToken().then((token) {
      _firestore.collection('vendors').doc(vendorId).update({'fcmToken': token});
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
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
    final String? leadId = message.data['leadId'];
    if (leadId != null) {
      // Handle navigation to lead details
      print('Navigating to Lead ID: $leadId');
      // You can use Get.to() or Get.off() to navigate to the Lead Details page
      // Get.to(() => LeadDetailView(leadId: leadId));
    }
  }

  void fetchAndListenForLeads() {
    _firestore.collection('leads').where('vendorIds', arrayContains: vendorId).snapshots().listen((querySnapshot) {
      leads.value = querySnapshot.docs.map((doc) => Lead.fromDocument(doc)).toList();
    });
  }

  Future<void> acceptLead(String leadId) async {
  try {
    await _firestore.collection('leads').doc(leadId).update({
      'acceptedBy': vendorId,
      'status': 'accepted',
    });
    Get.snackbar('Success', 'Lead accepted successfully!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);

    // Fetch the lead document and cast the data to a Map<String, dynamic>
    DocumentSnapshot leadDoc = await _firestore.collection('leads').doc(leadId).get();
    Map<String, dynamic>? leadData = leadDoc.data() as Map<String, dynamic>?;

    if (leadData != null) {
      // Move the accepted lead to the bookings collection
      await _firestore.collection('bookings').doc(leadId).set(leadData);

      // Optionally delete the lead from the leads collection
      await _firestore.collection('leads').doc(leadId).delete();
    } else {
      Get.snackbar('Error', 'Failed to fetch lead data', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to accept lead: $e', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }
}


Future<void> _checkAndUpdateVendorLocation() async {
  final status = await Permission.location.status;
  if (!status.isGranted) {
    if (await Permission.location.request().isGranted) {
      // Permission granted
      await _updateVendorLocation();
    } else {
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


}





class Lead {
  final String id;
  final Map<String, dynamic> details;
  final String? acceptedBy;
  final String status;

  Lead({
    required this.id,
    required this.details,
    this.acceptedBy,
    required this.status,
  });

  factory Lead.fromDocument(DocumentSnapshot doc) {
    return Lead(
      id: doc.id,
      details: doc['leadDetails'],
      acceptedBy: doc['acceptedBy'],
      status: doc['status'],
    );
  }
}
