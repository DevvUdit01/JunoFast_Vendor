import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePasswordController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    RxBool passed1 =true.obs;
    RxBool passed2 =true.obs;
    RxBool passed3 =true.obs;
    RxBool isLoading = false.obs;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController conformPasswordController = TextEditingController();

  void changePassword(String oldPassword, String newPassword) async {

    if (user != null) {
      try {
        // Get the user's email (since we'll need it for re-authentication)
        String email = user!.email!;

        // Reauthenticate the user with the old password
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: oldPassword);
        await user!.reauthenticateWithCredential(credential);

        // If reauthentication is successful, update the password
        await user!.updatePassword(newPassword);
        print('Password successfully updated.');
        await _firestore.collection('vendors').doc(user!.uid).update({
        'password': newPassword,
        'conformPassword':newPassword,
        });
        // You may want to show a confirmation to the user
        isLoading.value = false;
        Get.back();
        Get.snackbar('Success', 'Password has been updated.',
            snackPosition: SnackPosition.BOTTOM);
            
      } on FirebaseAuthException catch (e) {  
        isLoading.value = false;    
        if (e.code == 'wrong-password') {
          print('The old password is incorrect.');
          Get.snackbar('Error', 'The old password is incorrect.',
              snackPosition: SnackPosition.BOTTOM);
        } else if (e.code == 'weak-password') {
          print('The new password is too weak.');
          Get.snackbar('Error',
              'The new password is too weak. Please choose a stronger password.',
              snackPosition: SnackPosition.BOTTOM);
        } else {
          print('Error: $e');
          Get.snackbar('Error',
              'The old password is incorrect.',
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        print('An unexpected error occurred: $e');
        Get.snackbar(
            'Error', 'An unexpected error occurred. Please try again later.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      print('No user is currently signed in.');
      Get.snackbar('Error', 'No user is currently signed in.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
