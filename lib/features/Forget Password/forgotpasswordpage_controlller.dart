
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswprdPageController extends GetxController{

  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendOTP()async {
   await auth.sendPasswordResetEmail(email: emailController.text.trim()).then((value){
   // Utils().toastMessage('We have sent you email to recover password, please check email.');
   print('send reset password link on your email');
   }).onError((error,StackTrace){
    // Utils().toastMessage(error.toString());
    print('error occured');
   });
  }


}