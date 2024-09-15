import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/firebasServices/auth_services.dart';

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
    print('signIn wiht google call');
    await AuthService.signInWithGoogle();
  }

 
  void _login() async {
     await AuthService.loginUser(
      emailController.text.trim(),
      passWordController.text.trim(),
    );
  }

}
