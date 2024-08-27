import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/Dashboard/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leads'),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (controller.leads.isEmpty) {
          return Center(
            child: Text('No leads available',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          );
        } else {
          return ListView.builder(
            itemCount: controller.leads.length,
            itemBuilder: (context, index) {
              final lead = controller.leads[index];
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(Icons.local_shipping, color: Colors.teal),
                  title: Text(
                    'Lead ID: ${lead.id}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text('Status: ${lead.status}'),
                      SizedBox(height: 5),
                      Text(
                          'Accepted By: ${lead.acceptedBy ?? "Not accepted yet"}'),
                    ],
                  ),
                  trailing: lead.status == 'pending'
                      ? ElevatedButton(
                          onPressed: () => controller.acceptLead(lead.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Accept Lead'),
                        )
                      : Icon(Icons.check_circle, color: Colors.green),
                  onTap: () {
                    // Handle lead click, e.g., show lead details
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
