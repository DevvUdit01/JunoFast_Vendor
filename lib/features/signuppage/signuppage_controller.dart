
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/firebasServices/auth_services.dart';
import '../../core/VendorModel/Vendor_model.dart';
import '../../routing/routes_constant.dart';

class SignUpPageController extends GetxController {
  RxBool isSet = true.obs;
  final signupKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  
  void checkValidation() {
  if (signupKey.currentState != null) {  // Check if formKey.currentState is not null
    if (signupKey.currentState!.validate()) {
      // Proceed if the form is valid
      print(
      'valid form'
      );
     // signUp();
     // Get.toNamed('/nextPage');  // Replace wit h your route
    } else {
      // Show error if the form is invalid
      }
  } else {
    // Handle the case where formKey.currentState is null
        return;
  }
}


   void signUp() async {
  VendorModel vendor = VendorModel(
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    mobileNumber: mobileController.text.trim(),
    firm: nameController.text.trim(),
    password: passwordController.text.trim(),
    conformPassword: cpasswordController.text.trim(),
    address: addressController.text.trim(),
    vehicleType: 'Truck',
    role: 'Fleet Owner',
    packing: 'Yes',
    registerFirm: true,
    booking: [], // Empty booking list initially
  );

    User? user = await AuthService.signUpWithEmailAndPassword(vendor);
    if (user != null) {
      print('Sign up successful!');
       Get.snackbar('Login', 'Login successfull ',backgroundColor: Color(0xFF12FD1A));
        Get.offAllNamed(RoutesConstant.dashpage);
    } else {
      print('Sign up failed.');
      Get.back();
       Get.snackbar('Sign Up', 'Sign up failed. ',backgroundColor: Color(0xFFFD1212));
    }
  }


}