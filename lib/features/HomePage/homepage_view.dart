import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'homepage_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  // Format Timestamp to a readable date string
  String formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width*0.5,
        child: ListView(
          children:[
         const UserAccountsDrawerHeader(
            accountName: Text("Admin Name"),
             accountEmail: Text("AdminName@gmail.com"),
             currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToQMu10bV9Vr8oWuZ1SfwfKG0LH4GQRj-RjK3pujOwSCULxevP8kXFHstKOg&s")),
             ),
          ListTile(
            leading:  const Icon(Icons.person),
            title: const Text("profile"),
            onTap: (){
             // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const UserProfilePage()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.currency_rupee_sharp),
            title: const Text("Payment"),
            onTap: (){},
          ), 
           ListTile(
            leading: const Icon(Icons.edit_document),
            title: const Text("Notes"),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help"),
            onTap: (){
             // Navigator.pop(context);
            },
          )  
          ],
        ),
        
      ),
      appBar: AppBar(
        title: const Text('Leads'),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (controller.leads.isEmpty) {
          return const Center(
            child: Text('No leads available',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          );
        } else {
          return ListView.builder(
            itemCount: controller.leads.length,
            itemBuilder: (context, index) {
              final lead = controller.leads[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(Icons.local_shipping, color: Colors.teal),
                  title: Text(
                    'Lead ID: ${lead.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(height: 5),
    Text('Status: ${lead.status}'),
    const SizedBox(height: 5),
    Text('Pickup Location: ${lead.pickupLocation.latitude}, ${lead.pickupLocation.longitude}'),
    Text('Drop Location: ${lead.dropLocation.latitude}, ${lead.dropLocation.longitude}'),
    Text('Vehicle Type: ${lead.vehicleType}'),
    Text('Client Name: ${lead.clientName}'),  // Accessing clientName
    Text('Client Number: ${lead.clientNumber}'),  // Accessing clientNumber
    Text('Amount: ${lead.amount}'),  // Accessing amount
    Text('Timestamp: ${formatTimestamp(lead.timestamp)}'),
    const SizedBox(height: 5),
    Text('Accepted By: ${lead.acceptedBy ?? "Not accepted yet"}'),
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
                          child: const Text('Accept Lead'),
                        )
                      : const Icon(Icons.check_circle, color: Colors.green),
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
