import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/core/globals.dart' as gbl;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:junofast_vendor/UIHelper/ui_helper.dart';
import 'package:junofast_vendor/features/formpage/formpage_view.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/VendorModel/Vendor_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
 // Signup function
static Future<void> signUpWithEmailAndPassword(VendorModel vendor) async {
  try {
    customDialog();

    // Check if email or mobile number is already in Firestore
    final QuerySnapshot emailSnapshot = await _firestore
        .collection('vendors')
        .where('email', isEqualTo: vendor.email)
        .get();

    final QuerySnapshot phoneSnapshot = await _firestore
        .collection('vendors')
        .where('mobileNumber', isEqualTo: vendor.mobileNumber)
        .get();

    if (emailSnapshot.docs.isNotEmpty) {
      Get.back();
      Get.snackbar(
        'Error',
        'The email address is already in use by another account.',
        backgroundColor: const Color(0xFFFD1212),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (phoneSnapshot.docs.isNotEmpty) {
      Get.back();
      Get.snackbar(
        'Error',
        'The mobile number is already in use by another account.',
        backgroundColor: const Color(0xFFFD1212),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Create user
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: vendor.email,
      password: vendor.password,
    );

    if (userCredential.user != null) {
      User? user = userCredential.user;

      // Send email verification
     // await user!.sendEmailVerification();
         // Store vendor details to Firestore after email verification
       await _firestore.collection('vendors').doc(user!.uid).set(vendor.toMap());
      setLoginValue(true); // Assuming this handles user login state
     String? uid = user.uid;
      setCurrentUserUID(uid);
      Get.back();
      Get.snackbar(
        'Sign Up',
        'Link sent successfully. Please verify your email before logging in.',
        backgroundColor: const Color(0xFF12FD1A),
        snackPosition: SnackPosition.BOTTOM,
      );
       Get.offAllNamed(RoutesConstant.dashpage);
      // Start checking for email verification periodically
     // await _checkEmailVerificationPeriodically(user, vendor);

    } else {
      Get.back();
      User? user = _auth.currentUser;
      user!.delete();
      Get.snackbar(
        'Sign Up',
        'Sign up failed. Please try again.',
        backgroundColor: const Color(0xFFFD1212),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } on FirebaseAuthException catch (e) {
    Get.back();
    User? user = _auth.currentUser;
    user!.delete();
    Get.snackbar(
      'Error',
      _handleAuthError(e),
      backgroundColor: const Color(0xFFFD1212),
      snackPosition: SnackPosition.BOTTOM,
    );
  } catch (e) {
    Get.back();
    User? user = _auth.currentUser;
    user!.delete();
    Get.snackbar(
      'Error',
      'An unexpected error occurred. Please try again.',
      backgroundColor: const Color(0xFFFD1212),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

// Function to periodically check email verification
// Function to periodically check email verification
static Future<void> _checkEmailVerificationPeriodically(User user, VendorModel vendor) async {
  bool isEmailVerified = false;
  int maxRetries = 20; // Check every 15 seconds for 5 minutes (300 seconds total)
  int retryCount = 0;

  // Check the email verification status every 15 seconds, up to 20 retries
  while (!isEmailVerified && retryCount < maxRetries) {
    await Future.delayed(const Duration(seconds: 15)); // Wait 15 seconds before each check
    await user.reload(); // Reload user to fetch updated status
    isEmailVerified = user.emailVerified;
    print(isEmailVerified);
    print('line no 117');
    if (isEmailVerified) {
      print('line no 119');
      // If email is verified, call checkEmailVerification and break the loop
      await checkEmailVerification(vendor);
      break;
    }

    retryCount++;
  }

  if (!isEmailVerified) {
    // If the email is still not verified after retries, show a warning
    Get.snackbar(
      'Email Not Verified',
      'You did not verify your email in time. Please try again.',
      backgroundColor: const Color(0xFFFD1212),
      snackPosition: SnackPosition.BOTTOM,
    );

    User? user = _auth.currentUser;
    user!.delete();
    Get.offAllNamed(RoutesConstant.loginpage);
  }
}

// Handle email verification and vendor data storage
static Future<void> checkEmailVerification(VendorModel vendor) async {
  User? user = _auth.currentUser;
  print('line no 143');
  // Store vendor details to Firestore after email verification
  await _firestore.collection('vendors').doc(user!.uid).set(vendor.toMap());

  setLoginValue(true); // Assuming this handles user login state
  String? uid = user.uid;
  setCurrentUserUID(uid);
  Get.snackbar(
    'Success',
    'Email verified and data stored successfully.',
    backgroundColor: Colors.green,
  );
  Get.offAllNamed(RoutesConstant.dashpage); // Redirect to dashboard
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      print('line no 185  ${user?.emailVerified}');
      if (user != null && !user.emailVerified) {
        Get.back();
        Get.snackbar(
          'Error',
          'Email is not verified. Please check your inbox.',
          backgroundColor: Colors.red,
        );
        return;
      }
      String? uid = user!.uid;
      setCurrentUserUID(uid);
      setLoginValue(true);
      Get.snackbar('Success', 'Login successful', backgroundColor: Colors.green);
      Get.offAllNamed(RoutesConstant.dashpage);
    } catch (e) {
      Get.back();
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  // login with Google
  static Future<void> signInWithGoogle() async {
    try {
      customDialog();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Get.back();
        Get.snackbar("Sign-In Cancelled", "User cancelled the sign-in process",
            backgroundColor: Colors.red);
        return;
      }

      final String googleEmail = googleUser.email;
      QuerySnapshot vendorSnapshot = await FirebaseFirestore.instance
          .collection('vendors')
          .where('email', isEqualTo: googleEmail)
          .get();

      if (vendorSnapshot.docs.isEmpty) {
        Get.back();
        Get.snackbar("Error", "No User found with this email",
          backgroundColor: Colors.red);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
      );

        await _auth.signInWithCredential(credential).then((userCredential) async {
        await googleSignIn.disconnect();
        setLoginValue(true);
        String? uid = userCredential.user!.uid;
        setCurrentUserUID(uid);
        Get.offAllNamed(RoutesConstant.dashpage);
        Get.snackbar("Success", "Login Successful",
        backgroundColor: const Color(0xFF27F52E));
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Error", e.code.toString(), backgroundColor: Colors.red);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  // signUpWithGoogle
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
      final String? googleName = googleUser.displayName;
      // Authenticate with Firebase using Google credentials
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in or create a user in Firebase Authentication
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if the vendor already exists in Firestore
        final vendorDoc =
            await _firestore.collection('vendors').doc(user.uid).get();

        if (!vendorDoc.exists) {
          print('line no 262');
           // Navigate to form page to collect additional vendor details
    final VendorModel? newVendor = await Get.off<VendorModel>(FormPageView(),
      arguments: {'email': googleEmail, 'name': googleName},
    );
          // Ensure the vendor model is returned
          if (newVendor != null) {
            print('line no 273');
            customDialog();
            // Save vendor details to Firestore
            await _firestore
                .collection('vendors')
                .doc(user.uid)
                .set(newVendor.toMap());
                Get.back();
                setLoginValue(true);
                String? uid = user.uid;
                setCurrentUserUID(uid);
            Get.snackbar("Success", "User account created successfully",
                backgroundColor: Colors.green);
                Get.offAllNamed(RoutesConstant.dashpage);
          } else {
             print('line no 283');
              Get.back();
               User? user = _auth.currentUser;
               user!.delete();
            // Vendor form was canceled
            Get.snackbar("Error", "User creation canceled",
              backgroundColor: Colors.red);
          }
        } 
        print('user note create');
      } else {
        Get.back();
        Get.snackbar("Error", "Failed to sign in with Google",
            backgroundColor: Colors.red);
      }
       
      // Disconnect Google Sign-In
      await googleSignIn.disconnect();
    } on FirebaseAuthException catch (e) {
      print("Firebase ${e.code.toString()}");
      Get.back();
      Get.snackbar("Error", e.message ?? "Unknown Firebase error",
          backgroundColor: Colors.red);
    } catch (e) {
      print("Error catch ${e.toString()}");
      Get.back();
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

// Logout
  static Future<void> signOut() async {
    await _auth.signOut();
    setLoginValue(false);
    setCurrentUserUID("");
  }

  static Future<void> setLoginValue(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gbl.isLogin.value = value;
    prefs.setBool("isLogin", gbl.isLogin.value);
  }

  static Future<void> getLoginValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gbl.isLogin.value = prefs.getBool("isLogin") ?? false;
  }

   static Future<void> setCurrentUserUID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gbl.currentUserUID.value = value;
    prefs.setString("currentUserUID", gbl.currentUserUID.value);
  }

  static Future<void> getCurrentUserUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gbl.currentUserUID.value = prefs.getString("currentUserUID")??'';
  }
}