import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void sendOTP() async {
    String email = emailController.text.trim();

    try {
      // Check if the email exists in the vendors collection
      QuerySnapshot vendorSnapshot = await firestore
          .collection('vendors')
          .where('email', isEqualTo: email)
          .get();

      if (vendorSnapshot.docs.isNotEmpty) {
        // Email exists in the vendors collection
        await auth.sendPasswordResetEmail(email: email);
        Get.snackbar("Success", "We have sent you an email to recover your password, please check your inbox.", backgroundColor: const Color(0xFF27F52E));
      } else {
        // Email not found in the vendors collection
        Get.snackbar("Failed", "Email does not exist in the vendors database.", backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar("Failed", error.toString(), backgroundColor: Colors.red);
    }
  }
}
