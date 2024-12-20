import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:junofast_vendor/features/PaymentPage/paymentpage_view.dart';
import 'package:junofast_vendor/features/ProfilePage/profilepage_controller.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
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
    // ignore: unused_local_variable
    ProfilePageController pageController = Get.put(ProfilePageController());
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView(
          children: [
             const UserAccountsDrawerHeader(
              accountName: Text("user Name"),
              accountEmail: Text("UserEmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToQMu10bV9Vr8oWuZ1SfwfKG0LH4GQRj-RjK3pujOwSCULxevP8kXFHstKOg&s"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Get.toNamed(RoutesConstant.profilepage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.currency_rupee_sharp),
              title: const Text("Payment"),
              onTap: () {
                Get.to(const PaymentPageView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              title: const Text("Notes"),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Help"),
              onTap: () {
               Get.toNamed(RoutesConstant.helpSupport);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Leads'),
        backgroundColor: Colors.orange,
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
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_shipping, color: Colors.amber, size: 50),
                      Text(
                      'Lead Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                            children: [
                              const Text(
                                'Pickup Location: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(
                                lead.pickupLocation,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                           Row(
                            children: [
                              const Text(
                                'Drop Location: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(
                                lead.dropLocation,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                           Row(
                            children: [
                              const Text(
                                'Amount: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                             Text(
                                lead.amount.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          const Text(
                            'Status: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Text(
                            lead.status,
                            style: const TextStyle(fontSize: 18),
                          ),
                           ],
                      ),
                          Row(
                            children: [
                              const Text(
                                'Type of lead: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(
                            lead.leadPermission,
                            style: const TextStyle(fontSize: 18),
                          ),
                       
                            ],
                          ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'lead creation time: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(
                                formatTimestamp(lead.timestamp),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      lead.status == 'pending'
                          ? Center(
                              child: ElevatedButton(
                                onPressed: () => controller.acceptLead(lead.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Accept Lead',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xFF3FFF45),
                                size: 50,
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
