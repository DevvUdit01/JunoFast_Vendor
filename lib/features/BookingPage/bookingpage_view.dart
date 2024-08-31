import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bookingpage_controller.dart';

class BookingPageView extends GetView<BookingPageController> {
  const BookingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

  

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('vendors')
            .where('vehicleType', isEqualTo: 'car')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No bookings available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final lead = doc.data() as Map<String, dynamic>;
              String bookingId = lead['bookingId'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('bookings')
                    .doc(bookingId)
                    .get(),
                builder: (context, bookingSnapshot) {
                  if (bookingSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!bookingSnapshot.hasData ||
                      !bookingSnapshot.data!.exists) {
                    return const Center(
                      child: Text(
                        'Booking not found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  final bookingData =
                      bookingSnapshot.data!.data() as Map<String, dynamic>;

                  return Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading:
                          const Icon(Icons.local_shipping, color: Colors.teal),
                      title: Text(
                        'Booking ID: $bookingId',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text('Status: ${bookingData['status']}'),
                          const SizedBox(height: 5),
                          Text(
                              'Pickup Location: ${bookingData['pickupLocation']['latitude']}, ${bookingData['pickupLocation']['longitude']}'),
                          Text(
                              'Drop Location: ${bookingData['dropLocation']['latitude']}, ${bookingData['dropLocation']['longitude']}'),
                          Text('Vehicle Type: ${bookingData['vehicleType']}'),
                          const SizedBox(height: 5),
                          Text(
                              'Accepted By: ${bookingData['acceptedBy'] ?? "Not accepted yet"}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
