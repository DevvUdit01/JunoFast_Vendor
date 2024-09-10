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
  static Future<void> signUpWithEmailAndPassword(VendorModel vendor) async {
    try {
      customDialog();
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: vendor.email,
        password: vendor.password,
      );

      if (userCredential.user != null) {
        // Save vendor details to Firestore
        await _firestore.collection('vendors').doc(userCredential.user!.uid).set(vendor.toMap());
        
        Get.snackbar(
          'Sign Up',
          'User created successfully',
          backgroundColor: Color(0xFF12FD1A),
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(RoutesConstant.dashpage);
      } else {
        Get.back();
        Get.snackbar(
          'Sign Up',
          'Sign up failed. Please try again.',
          backgroundColor: Color(0xFFFD1212),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        _handleAuthError(e),
        backgroundColor: Color(0xFFFD1212),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        backgroundColor: Color(0xFFFD1212),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please enable the sign-in method.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  // Login with email and password

 static Future<void> loginUser(String email, String password) async {
    try {
      customDialog();
      // Query vendors collection for a document where email and password match
      QuerySnapshot vendorSnapshot = await _firestore
          .collection('vendors')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password) // Ensure password is stored securely (hashed)
          .get();

      if (vendorSnapshot.docs.isNotEmpty) {
        // Email and password match found in the vendors collection
        // Now you can perform login, e.g., Firebase authentication
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password, // For Firebase Auth, you need to store passwords hashed in Firestore
        );
        
        // Navigate to the home screen or show success message
        Get.back();
        Get.snackbar('Success', 'Login successful',backgroundColor: Colors.green);
        Get.offAllNamed(RoutesConstant.dashpage); // Navigate to the home screen
      } else {
        // No matching vendor found
        Get.back();
        Get.snackbar('Error', 'Invalid email or password',backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.back();
      // Handle errors like network issues or invalid credentials
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.red);
    }
  }

   // login with google
   static Future<void> signInWithGoogle() async {
    try {
      customDialog(); // Assuming this is a loading dialog function
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Get.back();
        Get.snackbar("Sign-In Cancelled", "User cancelled the sign-in process", backgroundColor: Colors.red);
        return;
      }

      final String googleEmail = googleUser.email;

      // Check if the email exists in the vendors collection
      QuerySnapshot vendorSnapshot = await FirebaseFirestore.instance
          .collection('vendors')
          .where('email', isEqualTo: googleEmail)
          .get();

      if (vendorSnapshot.docs.isEmpty) {
        // If no document found with the given email, don't allow login
        Get.back(); // Close the loading dialog
        Get.snackbar("Error", "No vendor found with this email", backgroundColor: Colors.red);
        return;
      }

      // If email exists in vendors collection, proceed with Google sign-in
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential).then((userCredential) async {
        await googleSignIn.disconnect();
        Get.back();
        Get.offAllNamed(RoutesConstant.dashpage); // Navigate to the dashboard page
        Get.snackbar("Success", "Login Successful", backgroundColor: const Color(0xFF27F52E));
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Error", e.code.toString(), backgroundColor: Colors.red);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
 

  static Future<void> signUpWithGoogle() async {
  try {
    customDialog(); // Show loading dialog

    // Initialize Google sign-in process
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // User canceled Google Sign-In
      Get.back();
      Get.snackbar(
        "Sign-In Cancelled",
        "User cancelled the sign-in process",
        backgroundColor: Colors.red,
      );
      return;
    }

    // Get user information from Google account
    final String googleEmail = googleUser.email;
    final String googleId = googleUser.id;
    final String? googleName = googleUser.displayName;
    final String? googlePhotoUrl = googleUser.photoUrl;

    print("Email: $googleEmail, Id: $googleId, Name: $googleName, Photo: $googlePhotoUrl");

    // Authenticate with Firebase using Google credentials
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in or create a user in Firebase Authentication
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      // Check if the vendor already exists in Firestore
      final vendorDoc = await _firestore.collection('vendors').doc(user.uid).get();

      if (!vendorDoc.exists) {
        // Create a new vendor in Firestore if it doesn't exist
        VendorModel newVendor = VendorModel(
            email: googleEmail,
            name: googleName ?? 'No Name Provided',
            // Add any additional fields you want for the vendor
            address: '', mobileNumber: '', firm: 'user create by google', 
            password: '123', conformPassword: '123', 
            vehicleType: '', packing: '', 
            role: '', booking: [],
             registerFirm: true,     // Placeholder, update if needed
          );

        await _firestore.collection('vendors').doc(user.uid).set(newVendor.toMap());

        Get.snackbar("Success", "Vendor account created successfully", backgroundColor: Colors.green);
      } else {
        // Vendor already exists, just log in
        Get.snackbar("Welcome Back", "You are signed in successfully", backgroundColor: Colors.green);
      }

      // After successful sign-in, navigate to the dashboard
      Get.back(); // Close loading dialog
      Get.offAllNamed(RoutesConstant.dashpage); // Navigate to the dashboard
    } else {
      Get.back();
      Get.snackbar("Error", "Failed to sign in with Google", backgroundColor: Colors.red);
    }

    // Disconnect Google Sign-In
    await googleSignIn.disconnect();

  } on FirebaseAuthException catch (e) {
    print("Firebase ${e.code.toString()}");
    Get.back();
    Get.snackbar("Error", e.message ?? "Unknown Firebase error", backgroundColor: Colors.red);
  } catch (e) {
    print("Error catch ${e.toString()}");
    Get.back();
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  }
}



  // Logout
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
