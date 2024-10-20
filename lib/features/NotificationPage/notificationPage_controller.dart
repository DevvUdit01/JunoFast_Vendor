import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  // List of notifications using RxList for reactivity
  var notifications = List.generate(
    10,
    (index) => {
      'title': 'Notification ${index + 1}',
      'description': 'This is the description of notification ${index + 1}.',
      'timestamp': 'Oct 18, 2024 - 10:00 AM',
      'icon': Icons.notifications,
    },
  ).obs;

  // Method to remove a notification by index
  void removeNotification(int index) {
    notifications.removeAt(index);
  }
}
