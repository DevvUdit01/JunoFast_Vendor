import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../UIHelper/ui_helper.dart';
import '../../core/VendorModel/Vendor_model.dart';
import '../../firebasServices/auth_services.dart';
import '../../routing/routes_constant.dart';
import '../formpage/formpage_view.dart';

class PhoneAuthenticationController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> phoneKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _verificationId;
  RxBool isCodeSent = false.obs;
  RxBool isLoading = false.obs;
  RxInt remainingTime = 60.obs;
  Timer? timer;
  RxBool isResendEnabled = false.obs;

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.onClose();
  }

  // Validate phone number and send OTP
  void checkValidate({required isSignUp}) {
    if (phoneKey.currentState!.validate()) {
      fetchPhoneNumberAndSendOtp(isSignUp: isSignUp);
    }
  }

  // Fetch phone number from Firestore and send OTP
  Future<void> fetchPhoneNumberAndSendOtp({required isSignUp}) async {
    final phoneNumber = "+91${phoneController.text.trim()}";
    final vendorDoc = await _firestore.collection('vendors')
        .where('mobileNumber', isEqualTo: phoneNumber)
        .get();

    if (isSignUp==1 && vendorDoc.docs.isNotEmpty) {
      Get.snackbar("Error", "This mobile number already exists", backgroundColor: Colors.red);
    } else if (isSignUp==0 && vendorDoc.docs.isEmpty) {
      Get.snackbar("Error", "This mobile number does not exist", backgroundColor: Colors.red);
    } else {
      isLoading.value = true;
      sendOTP(phoneNumber);
    }
  }

  // Send OTP
  Future<void> sendOTP(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          isLoading.value = false;
        },
        verificationFailed: (FirebaseAuthException ex) {
          isLoading.value = false;
          handleAuthError(ex);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          isCodeSent.value = true;
          isLoading.value = false;
          startTimer();
          Get.snackbar("Info", "OTP sent to $phoneNumber", backgroundColor: Colors.green);
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          isResendEnabled.value = true;
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An internal error occurred. Please try again.");
    }
  }

  // Verify OTP for both sign-in and sign-up
  Future<void> verifyOtp({required  isSignUp}) async {
    if (otpController.text.isEmpty || otpController.text.length != 6) {
      Get.snackbar("Error", "Please enter a valid OTP", backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text.trim(),
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        if (isSignUp == 1) {
          await handleSignUp(user);
        } else {
          handleSignIn();
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "User verification failed", backgroundColor: Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.message ?? "Unknown Firebase error");
    }
  }

  // Handle sign-up logic
  Future<void> handleSignUp(User user) async {
    isLoading.value = false;
    final VendorModel? newVendor = await Get.to<VendorModel>(
      FormPageView(),
      arguments: {'phoneNumber': user.phoneNumber},
    );

    if (newVendor != null) {
      customDialog();
      await _firestore.collection('vendors').doc(user.uid).set(newVendor.toMap());
      Get.back();
      Get.snackbar("Success", "User account created successfully", backgroundColor: Colors.green);
      AuthService.setLoginValue(true);
      Get.offAllNamed(RoutesConstant.dashpage);
    } else {
      Get.back();
       User? user = _auth.currentUser;
       user!.delete();
      Get.snackbar("Error", "User creation canceled", backgroundColor: Colors.red);
    }
  }

  // Handle sign-in logic
  void handleSignIn() {
    isLoading.value = false;
    Get.snackbar("Success", "User Login successfully", backgroundColor: Colors.green);
    AuthService.setLoginValue(true);
    Get.offAllNamed(RoutesConstant.dashpage);
  }

  // Handle authentication errors
  void handleAuthError(FirebaseAuthException ex) {
    isLoading.value = false;
    String message;
    switch (ex.code) {
      case 'invalid-phone-number':
        message = "Invalid phone number.";
        break;
      case 'too-many-requests':
        message = "Too many requests. Please try again later.";
        break;
      case 'invalid-verification-code':
        message = "Invalid OTP. Please try again.";
        break;
      default:
        message = ex.message ?? "An unknown error occurred.";
        break;
    }
    Get.snackbar("Error", message);
  }

  // Start timer for resend OTP option
  void startTimer() {
    remainingTime.value = 60;
    isResendEnabled.value = false;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        isResendEnabled.value = true;
      }
    });
  }

  // Resend OTP if enabled
  void resendOtp({required isSignUp}) {
    if (isResendEnabled.value) {
      fetchPhoneNumberAndSendOtp(isSignUp:isSignUp);
    } else {
      Get.snackbar("Info", "Please wait until the timer ends.");
    }
  }
}