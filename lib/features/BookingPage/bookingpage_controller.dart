import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:junofast_vendor/firebasServices/auth_services.dart';
import '../../core/model.dart';
// ignore: unused_import
import '../../core/globals.dart'as gbl;

class BookingPageController extends GetxController {
  TextEditingController pickupDateController =TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String vendorId = FirebaseAuth.instance.currentUser!.uid; // Replace with actual vendor ID or fetch dynamically
  
  var processingBookings = <Booking>[].obs;
  var ongoingBookings = <Booking>[].obs;
  var completedBookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    AuthService.getCurrentUserUID();
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

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Update Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                    ),
                    fillColor: Colors.white,
                    filled: true),
            ),
            const SizedBox(height: 8,),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child:  TextField(
                controller: pickupDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Pickup Date",
                  suffixIcon: const Icon(Icons.calendar_today, color: Colors.orange),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    pickupDateController.text =
                    pickedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () { 
              Navigator.of(context).pop();
              pickupDateController.clear();
              amountController.clear();
              },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final amount = double.tryParse(amountController.text);
              if (amount != null  && pickupDateController.text !='') {
                //final formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                // Update the booking with the new amount, schedule time, and pickup date
                await _firestore.collection('bookings').doc(booking.id).update({
                  'amount': amount,
                  'pickupDate': pickupDateController.text,
                  'status': 'ongoing',
                });
                // Update the total amount in the payment collection
                await updateTotalAmountInPayment(booking.id, amount);
                Get.back(); // Close dialog
                pickupDateController.clear();
                amountController.clear();
              } else {
                Get.snackbar('Error', 'Please enter a valid amount, and pickup date');
              }
            },
            child: const Text('Submit'),
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
          title: const Text('Confirm Completion'),
          content: const Text('Are you sure you have completed the booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
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
              child: const Text('Yes'),
            ),
          ],
        );
      },
);
}

}