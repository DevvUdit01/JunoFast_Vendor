import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/model.dart';
import 'bookingpage_controller.dart';
import '../../core/globals.dart'as gbl;

// ignore: must_be_immutable
class BookingPageView extends StatelessWidget {
  final BookingPageController controller = Get.put(BookingPageController());

  BookingPageView({super.key});
    // Define colors based on the theme
    Color primaryColor = Colors.white;
    Color secondaryColor = Colors.orange;
    @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 2,
          iconTheme: IconThemeData(color: secondaryColor),
          title: Text(
            'Bookings',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          bottom: TabBar(
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            unselectedLabelColor: const Color.fromRGBO(189, 187, 187, 1),
            tabs: const [
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
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: secondaryColor, width: 1.5), // Orange border
                      ),
                      elevation: 5,
                      color: primaryColor, // White background
                      child: ListTile(
                        title: Text(
                          'Booking ID: ${booking.id}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: secondaryColor, // Orange for Booking ID
                          ),
                        ),
                        subtitle: Text(
                          'Status: ${booking.status}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black, // Black for status
                          ),
                        ),
                        trailing: booking.status == 'processing'
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                ),
                                onPressed: () =>
                                    controller.updateLead(context, booking),
                                child: const Text('Update'),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                ),
                                onPressed: () =>
                                    controller.markBookingAsCompleted(
                                        context, booking),
                                child: const Text('Mark as Completed'),
                              ),
                        onTap: () =>
                            _showBookingDetailsDialog(context, booking),
                      ),
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
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: primaryColor,
                      child: ListTile(
                        title: Text(
                          'Booking ID: ${booking.id}',
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            const Text('Status : ',
                              style: TextStyle(
                              fontSize: 16.0, color: Colors.black)),
                              Text(booking.status,
                              style: const TextStyle(
                              fontSize: 18.0, color: Colors.green)),
                          ],
                        ),
                        onTap: () =>
                            _showBookingDetailsDialog(context, booking),
                      ),
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

  Future<void> _showBookingDetailsDialog(
      BuildContext context, Booking booking) async {
    // Convert GeoPoint to real addresses
    // String pickupAddress = await _getAddressFromGeoPoint(booking.pickupLocation);
    // String dropAddress = await _getAddressFromGeoPoint(booking.dropLocation);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: Text(
            'Booking Details',
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Booking ID: ${booking.id}',
                style: TextStyle(color: secondaryColor)),
                Text('Client Name: ${booking.clientName}'),
                Text('Client Number: ${booking.clientNumber}'),
                Text('Vehicle Type: ${booking.vehicleType}'),
                Text('Pickup Location: ${booking.pickupLocation}'),
                Text('Drop Location: ${booking.dropLocation}'),
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
              child: Text(
                'Close',
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
