import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/NotificationPage/notificationPage_controller.dart';

class NotificationPageView extends GetView<NotificationPageController> {
  const NotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Primary color
        title: const Text('Notifications'),
      ),
      body: Obx(
        () => controller.notifications.isEmpty
            ? const Center(
                child: Text('No notifications available',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey)),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return NotificationCard(
                      title: notification['title'] as String,
                      description: notification['description'] as String,
                      timestamp: notification['timestamp'] as String,
                      icon: notification['icon'] as IconData,
                      onTap: () {
                        // Remove notification when tapped
                        controller.removeNotification(index);
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final VoidCallback onTap;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      color: Colors.white, // Secondary color
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange, // Primary color for the icon background
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black, // Secondary color text
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4.0),
            Text(
              timestamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.orange), // Primary color for the icon
        onTap: onTap, // Execute the onTap callback when tapped
      ),
    );
  }
}
