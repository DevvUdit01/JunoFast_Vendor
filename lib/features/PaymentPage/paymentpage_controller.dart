import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../core/globals.dart'as gbl;
import '../../firebasServices/auth_services.dart';

class PaymentPageController extends GetxController {
  
   var isLoading = false.obs;
   var payments = <Map<String, dynamic>>[].obs;
   String vendorId = gbl.currentUserUID.value;

   @override
  void onInit() {
    super.onInit();
    AuthService.getCurrentUserUID();
    fetchVendorPayments(vendorId);
  }

  // Listen to real-time changes in the 'payments' collection
  void fetchVendorPayments(String vendorId){
    FirebaseFirestore.instance
        .collection('payments').where('vendorId', isEqualTo: vendorId)
        .snapshots() // Listen for real-time updates
        .listen((snapshot) {
      isLoading(true); // Show loading indicator

      payments.value = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id; // Store document ID
        return data;
      }).toList();

      isLoading(false); // Hide loading indicator
    }, onError: (e) {
      isLoading(false);
      Get.snackbar('Error', 'Failed to fetch payments: $e');
    });
  }

}