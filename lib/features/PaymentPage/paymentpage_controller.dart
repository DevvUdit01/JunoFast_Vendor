import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentPageController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var payments = <Map<String, dynamic>>[].obs; // Observable list of payments
  var isLoading = false.obs;

  // Fetch payment details for the current vendor
  Future<void> fetchVendorPayments(String vendorId) async {
    try {
      isLoading.value = true;

      // Query the payments collection for the current vendor's payments
      QuerySnapshot snapshot = await _firestore
          .collection('payments')
          .where('vendorId', isEqualTo: vendorId)
          .get();

      // Clear the list before adding new data
      payments.clear();

      // Map the documents to a list of payment details
      snapshot.docs.forEach((doc) {
        payments.add(doc.data() as Map<String, dynamic>);
      });

    } catch (e) {
      print('Error fetching vendor payments: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
