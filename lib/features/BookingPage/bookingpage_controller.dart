import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/model.dart';

class BookingPageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String vendorId = "UDtTGLIHgdTQQFtTwXow"; // Replace with actual vendor ID or fetch dynamically

  var processingBookings = <Booking>[].obs;
  var ongoingBookings = <Booking>[].obs;
  var completedBookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookingsForVendor();
  }

 void fetchBookingsForVendor() {
    _firestore
        .collection('bookings')
        .where('acceptedBy', isEqualTo: vendorId)
        .snapshots()
        .listen((querySnapshot) {
      print('Documents fetched: ${querySnapshot.docs.length}');
      
      var ongoing = <Booking>[];
      var completed = <Booking>[];

      for (var doc in querySnapshot.docs) {
        print('Processing document: ${doc.id}');
        var booking = Booking.fromDocument(doc);
        print('Booking status: ${booking.status}');

        if (booking.status == 'processing' || booking.status == 'ongoing') {
          ongoing.add(booking);
        } else if (booking.status == 'completed') {
          completed.add(booking);
        }
      }

      print('Ongoing bookings: ${ongoing.length}');
      print('Completed bookings: ${completed.length}');

      ongoingBookings.value = ongoing;
      completedBookings.value = completed;
    }, onError: (error) {
      print('Error fetching bookings: $error');
    });
  }

void updateLead(BuildContext context, Booking booking) {
  final amountController = TextEditingController(text: booking.amount.toString());
  final timeController = TextEditingController();
  DateTime? selectedDate;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: timeController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Schedule Time (e.g., 14:00)'),
            ),
            SizedBox(height: 10),
            Text('Select Pickup Date'),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
              },
              child: Text('Choose Date'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final amount = double.tryParse(amountController.text);
              final scheduleTime = timeController.text;

              if (amount != null && scheduleTime.isNotEmpty && selectedDate != null) {
                final formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

                // Update the booking with the new amount, schedule time, and pickup date
                await _firestore.collection('bookings').doc(booking.id).update({
                  'amount': amount,
                  'scheduleTime': scheduleTime,
                  'pickupDate': formattedDate,
                  'status': 'ongoing',
                });

                // Update the total amount in the payment collection
                await updateTotalAmountInPayment(booking.id, amount);

                Navigator.of(context).pop(); // Close dialog
              } else {
                Get.snackbar('Error', 'Please enter a valid amount, schedule time, and pickup date');
              }
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}

Future<void> updateTotalAmountInPayment(String bookingId, double updatedAmount) async {
  try {
    // Fetch the current payment document for this booking
    DocumentSnapshot paymentDoc = await _firestore.collection('payments').doc(bookingId).get();

    if (paymentDoc.exists) {
      // Get the current total amount from the payment document
      //double currentTotal = paymentDoc['totalAmount'] ?? 0.0;

      // Calculate the new total by adding the updated amount
      //double newTotal = currentTotal + updatedAmount;

      // Update the total amount in the payment collection
      await _firestore.collection('payments').doc(bookingId).update({
        'totalAmount': updatedAmount,
      });

      print('Total amount updated successfully.');
    } else {
      // If the payment document doesn't exist, create a new one
      await _firestore.collection('payment').doc(bookingId).set({
        'totalAmount': updatedAmount,
      });

      print('New payment document created with total amount.');
    }
  } catch (e) {
    print('Error updating total amount in payment: $e');
  }
}

 void markBookingAsCompleted(BuildContext context, Booking booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Completion'),
          content: Text('Are you sure you have completed the booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the booking status to "completed" in Firestore
                await _firestore.collection('bookings').doc(booking.id).update({
                  'status': 'completed',
                });

                // Remove the dialog
                Navigator.of(context).pop();

                // Show a success Snackbar
                Get.snackbar('Success', 'Booking has been marked as completed');

                // Refresh the list by calling fetchBookingsForVendor again
                fetchBookingsForVendor();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
);
}
}