import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/Dashboard/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController>{
  const DashboardView({super.key});

  @override

 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return Center(child: Text('No tasks available'));
        } else {
          return ListView.builder(
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              return ListTile(
                title: Text('Task ${task.id}'),
                subtitle: Text('Status: ${task.status}'),
                onTap: () {
                  // Handle task click, e.g., show task details
                },
              );
            },
          );
        }
      }),
    );
  }
}