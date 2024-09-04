
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
  
  void checkValidation() {
  if (signupKey.currentState != null) {  // Check if formKey.currentState is not null
    if (signupKey.currentState!.validate()) {
      // Proceed if the form is valid
      print(
      'valid form'
      );
      signUp();
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
      name: nameController.text,
      email: emailController.text,
      mobileNumber: mobileController.text,
      address: '123 Street Name',
      password: passwordController.text,
      vehicleType: 'Truck',
      yearOfManufacture: '2020',
      vehicleModel: 'Model X',
      licensePlateNumber: 'ABC123',
      vehicleIdentificationNumber: 'VIN123456',
      vehicleRegistration: 'REG123456',
      licenseNumber: 'LIC123456',
      expDateOfLicense: '2025-12-31',
      licenseImageUrl: '',
      operatingState: 'State X',
      nationalId: 'NID123456',
      insuranceProvider: 'Insurance Co',
      expDateOfInsurance: '2025-12-31',
      policyNumber: 'POL123456',
      proofOfInsurance: '',
      booking: [],
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