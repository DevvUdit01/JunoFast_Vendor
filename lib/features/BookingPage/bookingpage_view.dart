import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart'; // Add this import for geocoding
import 'package:junofast_vendor/core/model.dart';

import 'bookingpage_controller.dart';

class BookingPageView extends StatelessWidget {
  final BookingPageController controller = Get.put(BookingPageController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Ongoing Bookings Tab
            Obx(() {
              if (controller.ongoingBookings.isEmpty) {
                return const Center(child: Text('No ongoing bookings'));
              } else {
                return ListView.builder(
                  itemCount: controller.ongoingBookings.length,
                  itemBuilder: (context, index) {
                    final booking = controller.ongoingBookings[index];
                    return ListTile(
                      title: Text('Booking ID: ${booking.id}'),
                      subtitle: Text('Status: ${booking.status}'),
                      trailing: booking.status == 'processing'
                          ? ElevatedButton(
                              onPressed: () =>
                                  controller.updateLead(context, booking),
                              child: const Text('Update'),
                            )
                          : ElevatedButton(
                              onPressed: () =>
                                  controller.markBookingAsCompleted(
                                      context, booking),
                              child: const Text('Mark as Completed'),
                            ),
                      onTap: () => _showBookingDetailsDialog(context, booking),
                    );
                  },
                );
              }
            }),
            // Completed Bookings Tab
            Obx(() {
              if (controller.completedBookings.isEmpty) {
                return const Center(child: Text('No completed bookings'));
              } else {
                return ListView.builder(
                  itemCount: controller.completedBookings.length,
                  itemBuilder: (context, index) {
                    final booking = controller.completedBookings[index];
                    return ListTile(
                      title: Text('Booking ID: ${booking.id}'),
                      subtitle: Text('Status: ${booking.status}'),
                      onTap: () => _showBookingDetailsDialog(context, booking),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _showBookingDetailsDialog(BuildContext context, Booking booking) async {
    // Convert GeoPoint to real addresses
    String pickupAddress = await _getAddressFromGeoPoint(booking.pickupLocation);
    String dropAddress = await _getAddressFromGeoPoint(booking.dropLocation);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Booking ID: ${booking.id}'),
                Text('Client Name: ${booking.clientName}'),
                Text('Client Number: ${booking.clientNumber}'),
                Text('Vehicle Type: ${booking.vehicleType}'),
                Text('Pickup Location: $pickupAddress'),
                Text('Drop Location: $dropAddress'),
                Text('Pickup Date: ${booking.pickupDate}'),
                Text('Amount: ${booking.amount}'),
                Text('Status: ${booking.status}'),
                Text('Driver Name: ${booking.driverName ?? 'N/A'}'),
                Text('Driver Number: ${booking.driverNumber ?? 'N/A'}'),
                Text('Vehicle Details: ${booking.vehicleDetails ?? 'N/A'}'),
                Text('Vehicle Number: ${booking.vehicleNumber ?? 'N/A'}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

Future<String> _getAddressFromGeoPoint(GeoPoint geoPoint) async {
  try {
    print('Geocoding for: Latitude ${geoPoint.latitude}, Longitude ${geoPoint.longitude}');
    List<Placemark> placemarks = await placemarkFromCoordinates(
      geoPoint.latitude,
      geoPoint.longitude,
    );
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      return "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";
    }
  } catch (e) {
    print('Error getting address: $e');
  }
  return 'Address not available';
}
}