
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/VendorModel/Vendor_model.dart';
import '../../firebasServices/auth_services.dart';
import '../../routing/routes_constant.dart';

class FormPageController extends GetxController {
//   RxBool isSet = true.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  var packing = ''.obs;
  var role = ''.obs;
  var termCondition = false.obs;
  var registerFirm = false.obs;
  late EmailAuth emailAuth;
  String? typeOfVehicleRequired;

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
    if (formKey.currentState != null) {
      // Check if formKey.currentState is not null
      if (formKey.currentState!.validate()) {
        // Proceed if the form is valid
        if (packing.isEmpty) {
          Get.snackbar('Required','check packing',backgroundColor: Colors.red);
          print('check packing');
        } else if (role.isEmpty) {
          Get.snackbar('Required','check role',backgroundColor: Colors.red);
          print('check role');
        } else if (termCondition == false) {
          Get.snackbar('Required','check term and condition',backgroundColor: Colors.red);
          print('check term and condition');
        } else if (registerFirm == false) {
          Get.snackbar('Required','check register firm',backgroundColor: Colors.red);
          print('check register firm');
        }else if(passwordController.text != cpasswordController.text){
            Get.snackbar('Error','Please Match password and conform password',backgroundColor: Colors.red);
        }
         else {
          signUp();

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
  void signUp() async {
  VendorModel vendor = VendorModel(
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    mobileNumber: mobileController.text.trim(),
    firm: firmController.text.trim(),
    password: passwordController.text.trim(),
    conformPassword: cpasswordController.text.trim(),
    address: addressController.text.trim(),
    vehicleType: typeOfVehicleRequired!,
    role: role.value,
    packing: packing.value,
    registerFirm: registerFirm.value,
    booking: [], // Empty booking list initially
  );

    
  }

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

  void loginWithGoogle() async{
    await AuthService.signUpWithGoogle();
  }

}
