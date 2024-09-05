import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'paymentpage_controller.dart';

class PaymentPageView extends StatelessWidget {
  final String vendorId = 'UDtTGLIHgdTQQFtTwXow'; // Vendor ID to fetch payments

  @override
  Widget build(BuildContext context) {
    // Instantiate the PaymentController
    final PaymentPageController paymentController = Get.put(PaymentPageController());

    // Fetch the payments when the view is first built
    paymentController.fetchVendorPayments(vendorId);

    // Define colors based on the theme
    Color primaryColor = Colors.white;
    Color secondaryColor = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        backgroundColor: secondaryColor,
      ),
      body: Obx(() {
        // Show a loading indicator while fetching data
        if (paymentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if there are no payments
        if (paymentController.payments.isEmpty) {
          return Center(
            child: Text('No payment details available.'),
          );
        }

        // ListView to display payment details
        return ListView.builder(
          itemCount: paymentController.payments.length,
          itemBuilder: (context, index) {
            // Get payment details for the current item
            Map<String, dynamic> payment = paymentController.payments[index];

            // Extract payment details
            String bookingId = payment['bookingId'] ?? 'N/A';
            double totalAmount = payment['totalAmount'] ?? 0.0;
            double amountReceived = payment['amountReceived'] ?? 0.0;

            return Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: secondaryColor, width: 1.5), // Thin orange border
              ),
              elevation: 5,
              color: primaryColor, // Set card color to white (primary)
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking ID: $bookingId',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: secondaryColor, // Orange color for Booking ID
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount Received:',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          '₹${amountReceived.toStringAsFixed(2)}', // Using rupee symbol
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}', // Using rupee symbol
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
