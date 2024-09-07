import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Get Address from latitude and longitude
  Future<String> getAddressFromLatLng(GeoPoint geoPoint) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        geoPoint.latitude,
        geoPoint.longitude,
      );
      Placemark place = placemarks[0];
      return "${place.street},${place.locality},${place.subLocality},(${place.postalCode}), ${place.administrativeArea}, ${place.country}.";
    } catch (e) {
      return "Address not available";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Admin Name"),
              accountEmail: Text("AdminName@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToQMu10bV9Vr8oWuZ1SfwfKG0LH4GQRj-RjK3pujOwSCULxevP8kXFHstKOg&s"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.currency_rupee_sharp),
              title: const Text("Payment"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              title: const Text("Notes"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Help"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Leads'),
        backgroundColor: Colors.amber,
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

              return FutureBuilder(
                future: Future.wait([
                  getAddressFromLatLng(lead.pickupLocation), // Fetch pickup location
                  getAddressFromLatLng(lead.dropLocation),   // Fetch drop location
                ]),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(), // Show loading indicator
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error getting address'));
                  } else if (snapshot.hasData) {
                    final pickupAddress = snapshot.data![0]; // First is pickup address
                    final dropAddress = snapshot.data![1];   // Second is drop address

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
                              '  Drop Location: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Drop Location: $dropAddress',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Pickup Location: $pickupAddress',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
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
                                      'Vehicle Type: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                    Text(
                                      lead.vehicleType,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'DateTime: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                    Text(
                                      formatTimestamp(lead.timestamp),
                                      style: const TextStyle(fontSize: 18),
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
                  } else {
                    return const Center(child: Text('No data'));
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
