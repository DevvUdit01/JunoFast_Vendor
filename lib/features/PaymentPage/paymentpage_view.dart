import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'paymentpage_controller.dart';

class PaymentPageView extends StatelessWidget {
  const PaymentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the PaymentController
    final PaymentPageController paymentController = Get.put(PaymentPageController());
    // Fetch the payments when the view is first built
    paymentController.fetchVendorPayments(paymentController.vendorId);

    // Define colors based on the theme
    Color primaryColor = Colors.white;
    Color secondaryColor = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: secondaryColor,
      ),
      body: Obx(() {
        // Show a loading indicator while fetching data
        if (paymentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if there are no payments
        if (paymentController.payments.isEmpty) {
          return const Center(
            child: Text('No payment found.'), // Updated to "No payment found"
          );
        }

        // ListView to display payment details
        return ListView.builder(
          itemCount: paymentController.payments.length,
          itemBuilder: (context, index) {
            // Get payment details for the current item
            Map<String, dynamic> payment = paymentController.payments[index];

            // Extract payment details, using default values if null
            String bookingId = payment['bookingId'];
            int totalAmount = payment['totalAmount'].toInt();
            int amountReceived = (payment['amountReceived'] ?? 0).toInt();
            int remainingAmount = totalAmount - amountReceived;

            return Card(
              margin: const EdgeInsets.all(16.0),
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
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Amount Received:',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          '₹${amountReceived.toStringAsFixed(2)}', // Using rupee symbol
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Remaining Amount:',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          '₹${remainingAmount.toStringAsFixed(2)}', // Using rupee symbol
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount:',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}', // Using rupee symbol
                          style: const TextStyle(
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
