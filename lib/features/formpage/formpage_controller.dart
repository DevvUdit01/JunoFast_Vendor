import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/VendorModel/Vendor_model.dart';

class FormPageController extends GetxController {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  
  var packing = ''.obs;
  String? role;
  var termCondition = false.obs;
  var registerFirm = false.obs;
  var isGoogleLoging = false.obs;
  late List<String> leadPermission = [];   // Updated to List<String>

  @override
  void onInit() {
    super.onInit();
    // If arguments are passed (e.g., Google sign-in info), populate fields
    Map<String, dynamic>? arguments = Get.arguments;
    if (arguments != null) {
      emailController.text = arguments['email'] ?? '';
      nameController.text = arguments['name'] ?? '';
    }
  }

  void checkValidation() {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        if (packing.isEmpty) {
          Get.snackbar('Required', 'Check packing', backgroundColor: Colors.red);
        } else if (role == null || role!.isEmpty) {
          Get.snackbar('Required', 'Check role', backgroundColor: Colors.red);
        } else if (!termCondition.value) {
          Get.snackbar('Required', 'Accept terms and conditions', backgroundColor: Colors.red);
        } else if (!registerFirm.value) {
          Get.snackbar('Required', 'Confirm firm registration', backgroundColor: Colors.red);
        } else if (passwordController.text != cpasswordController.text) {
          Get.snackbar('Error', 'Passwords do not match', backgroundColor: Colors.red);
        } else {
           leadPermission.clear(); // Clear any previously added permissions

       if (role == 'Transport Agent') {
         leadPermission.add('Industrial Transportation');
       } 
       if (role == 'Packers & Movers') {
         leadPermission.addAll([
           'House Shifting',
           'PG Shifting',
           'Office Relocation',
           'Bike Carrier',
           'Parcel/Courier'
         ]);
       } 
       if (role == 'Field Officer') {
         leadPermission.add('Industrial Transportation');
       } 
       if (role == 'Car Carrier') {
         leadPermission.addAll([
           'Car Transportation',
           'Bike Transportation'
         ]);
       } 
       if (role == 'Bike Carrier') {
         leadPermission.add('Bike Transportation');
       }
          signUp();
        }
      } else {
        print('Invalid form');
      }
    } else {
      print('form key is null');
    }
  }

  void signUp() async {
    VendorModel vendor = VendorModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobileNumber: phoneController.text.trim(),
      firm: firmController.text.trim(),
      password: passwordController.text.trim(),
      conformPassword: cpasswordController.text.trim(),
      address: addressController.text.trim(),
      leadPermission: leadPermission, // Updated to List<String>
      role: role!,
      packing: packing.value,
      registerFirm: registerFirm.value,
      bookings: [], // Empty booking list initially
      location: {}, // Assuming no location data initially
      fcmToken: '', // Assuming no FCM token initially
    );

    // Return the vendor model to the previous page
    Get.back(result: vendor);
  }

  // Method to select packing
  String selectPacking(String selectedPacking) {
    packing.value = selectedPacking;
    return packing.value;
  }

  // Method to select role
  String selectRole(String selectedUser) {
    role = selectedUser;
    return role!;
  }




}