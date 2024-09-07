import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/firebasServices/auth_services.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';

class LoginPageController extends GetxController {
  RxBool isSet = true.obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
 
  void checkValidation() {
    if (loginKey.currentState!.validate()) {
    _login();
    }
    return;
  }

  void loginWithGoogle() async{
    await AuthService.signUpWithGoogle();
  }

 
  void _login() async {
    User? user = await AuthService.loginWithEmailAndPassword(
      emailController.text,
      passWordController.text,
    );
    if (user != null) {
      Get.snackbar('Login', 'Login successfull ',backgroundColor: Color(0xFF12FD1A));
      Get.offAllNamed(RoutesConstant.dashpage);
      print('Login successful!');
    } else {
      Get.back();
      Get.snackbar('Login', 'Login failed ',backgroundColor: const Color(0xFFFD1212));
      print('Login failed.');
    }
  } 

}
