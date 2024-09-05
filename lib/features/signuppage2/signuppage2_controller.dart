import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';

class SignUpPageController2 extends GetxController {
//   RxBool isSet = true.obs;
  final signupKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressesController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  var packing = ''.obs;
  var role = ''.obs;
  var termCondition = false.obs;
  var registerFirm = false.obs;
  late EmailAuth emailAuth;

  var remoteServerConfiguration = {
    "server":"https://mail-about.herokuapp.com",
    "serverkey":"defkey",
  };

  @override
  void onInit() {
    super.onInit();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
      emailAuth.config(remoteServerConfiguration);
    
  }

  void checkValidation() {
    if (signupKey.currentState != null) {
      // Check if formKey.currentState is not null
      if (signupKey.currentState!.validate()) {
        // Proceed if the form is valid
        if (packing.isEmpty) {
          print('check packing');
        } else if (role.isEmpty) {
          print('check role');
        } else if (termCondition == false) {
          print('check term and condition');
        } else if (registerFirm == false) {
          print('check register firm');
        } else {
          // Get.offAllNamed(RoutesConstant.phoneAuth,
          //     arguments: phoneController.text);
           sendOtp();
         // Get.toNamed(RoutesConstant.verifyEmailOTP);
          print('valid form');
        }
        // signUp();
        // Get.toNamed('/nextPage');  // Replace wit h your route
      } else {
        // Show error if the form is invalid
        print('Invalid form');
      }
    } else {
      // Handle the case where formKey.currentState is null
      print('form key null');
      return;
    }
  }

//      void signUp() async {
//     VendorModel vendor = VendorModel(
//       name: nameController.text,
//       email: emailController.text,
//       mobileNumber: mobileController.text,
//       address: '123 Street Name',
//       password: passwordController.text,
//       vehicleType: 'Truck',
//       expDateOfInsurance: '2025-12-31',
//       policyNumber: 'POL123456',
//       proofOfInsurance: '',
//       booking: [],
//     );

//     User? user = await AuthService.signUpWithEmailAndPassword(vendor);
//     if (user != null) {
//       print('Sign up successful!');
//        Get.snackbar('Login', 'Login successfull ',backgroundColor: Color(0xFF12FD1A));
//         Get.offAllNamed(RoutesConstant.dashpage);
//     } else {
//       print('Sign up failed.');
//       Get.back();
//        Get.snackbar('Sign Up', 'Sign up failed. ',backgroundColor: Color(0xFFFD1212));
//     }
//   }

  String selectPacking(String selectedPaking) {
    if (selectedPaking == 'Yes') {
      packing.value = selectedPaking;
      return packing.value;
    } else if (selectedPaking == 'No') {
      packing.value = selectedPaking;
      return packing.value;
    } else {
      return packing.value;
    }
  }

  String selectRole(String selectedUser) {
    if (selectedUser == 'Fleet Owner') {
      role.value = selectedUser;
      return role.value;
    } else if (selectedUser == 'Packers & Movers') {
      role.value = selectedUser;
      return role.value;
    } else {
      return role.value;
    }
  }

  void verify() {
    var res = emailAuth.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: otpcontroller.value.text);
    if (res) {
      print('OTP Verified');
    } else {
      print('Invalid OTP');
    }
  }

 void sendOtp() async {
  try {
    bool res = await emailAuth.sendOtp(
      recipientMail: emailController.text,
      otpLength: 5,
    );
    if (res) {
      print("OTP sent");
      Get.snackbar('OTP Sent', 'OTP has been sent to your email.');
      Get.toNamed(RoutesConstant.verifyEmailOTP);
    } else {
      print('Failed to send OTP');
      Get.snackbar('Error', 'Failed to send OTP. Invalid email or server issue.');
    }
  } catch (e) {
    print('Error sending OTP: $e');
    Get.snackbar('Error', 'An error occurred while sending OTP.');
  }
}

}
