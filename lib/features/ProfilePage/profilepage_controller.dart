import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePageController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isEditing = false.obs;
  
  @override
  void onInit() {
    fetchUserData();
     isEditing = false.obs;
    super.onInit();
  }

  // TextEditingControllers to manage the text fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await _firestore.collection('vendors').doc(user.uid).get();
      // Assuming your Firestore user document has these fields
      usernameController.text = userData['name'];
      emailController.text = userData['email'];
      phoneController.text = userData['mobileNumber'];
      addressController.text = userData['address'];
    }
  }

  // Update user information in Firestore
  Future<void> updateUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('vendors').doc(user.uid).update({
        'name': usernameController.text.trim(),
        'address': addressController.text.trim(),
        'mobileNumber': phoneController.text.trim(),
      });
      Get.snackbar('Success', 'Account details updated successfully!');
    }
  }
}