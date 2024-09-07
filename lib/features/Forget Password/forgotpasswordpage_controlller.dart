
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswprdPageController extends GetxController{

  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendOTP()async {
   await auth.sendPasswordResetEmail(email: emailController.text.trim()).then((value){
     // Utils().toastMessage('We have sent you email to recover password, please check email.');
      Get.snackbar("Success", "We have sent you email to recover password, please check email.",backgroundColor: const Color(0xFF27F52E));
   }).onError((error,StackTrace){
      // Utils().toastMessage(error.toString());
       Get.snackbar("Failed", error.toString(),backgroundColor:  Colors.red);
   });
  }


}