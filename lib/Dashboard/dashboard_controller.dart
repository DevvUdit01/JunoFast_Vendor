import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  var tasks = <Task>[].obs;
  
  // Manually define a vendorId for dummy data
  final String vendorId = '4cYDPEJxTEEUFoqNgTVW'; // Replace with actual vendor ID if needed

  @override
  void onInit() async {
    super.onInit();
    listenForTasks();

    // Fetch and store the FCM token
    String? token = await _firebaseMessaging.getToken();
    _firestore.collection('vendors').doc(vendorId).update({
      'fcmToken': token,
    });

    print("FCM Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.messageId}');
      // Show notification or update UI with task details
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.messageId}');
      // Navigate to task details page
    });
  }

  void listenForTasks() {
    _firestore.collection('tasks')
      .where('vendorIds', arrayContains: vendorId)
      .snapshots()
      .listen((querySnapshot) {
        tasks.value = querySnapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
      });
  }
}

class Task {
  final String id;
  final Map<String, dynamic> details;
  final String? acceptedBy;
  final String status;

  Task({required this.id, required this.details, this.acceptedBy, required this.status});

  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      details: doc['taskDetails'],
      acceptedBy: doc['acceptedBy'],
      status: doc['status'],
    );
  }
}
