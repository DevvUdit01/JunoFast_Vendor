import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:junofast_vendor/UIHelper/ui_helper.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
import '../core/VendorModel/Vendor_model.dart';

class AuthService {
  static final  FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
 static Future<User?> signUpWithEmailAndPassword(VendorModel vendor) async {
    try {
      customDialog();
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: vendor.email,
        password: vendor.password,
      );

      // Save vendor details to Firestore
      await _firestore.collection('vendors').doc(userCredential.user!.uid).set(vendor.toMap());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Login with email and password
  static  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      customDialog();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar('Error', e.code.toString(),backgroundColor: Colors.red);
      return null;
    }
  }

   // login with google
   static Future<void> signUpWithGoogle() async {
    try {
      customDialog();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Get.back();
        // If the user cancels the sign-in process
        Get.snackbar("Sign-In Cancelled", "User cancelled the sign-in process",backgroundColor: Colors.red);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential).then((userCredential) async {
        await googleSignIn.disconnect();
        Get.back();
        Get.offAllNamed(RoutesConstant.dashpage);
        Get.snackbar("Success", "Login Successful",backgroundColor: const Color(0xFF27F52E));
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Error", e.code.toString(),backgroundColor: Colors.red);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.red);
    }

  }

  // Logout
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
