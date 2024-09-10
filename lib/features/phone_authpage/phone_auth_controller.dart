import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
import '../../UIHelper/ui_helper.dart';

class PhoneAuthenticationController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> phoneKey = GlobalKey();
  late String _verificationId;
  RxBool isCodeSent = false.obs;
  RxBool isLoading = false.obs;
  RxInt remainingTime = 60.obs;
  Timer? timer;
  RxBool isResendEnabled = false.obs; // Flag for resend OTP
  
  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.onClose();
  }

  void checkValidate() {
    if (phoneKey.currentState!.validate()) {
      verifyNumber();
    }
  }

  Future<void> verifyNumber() async {
    // Validate phone number format before proceeding
    if (!validatePhoneNumber(phoneController.text)) {
      Get.snackbar('Error', 'Invalid phone number format');
      return;
    }

    isLoading.value = true;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text.trim()}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          isLoading.value = false;
          Get.offAllNamed(RoutesConstant.dashpage);
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
          print("Code sent to ${phoneController.text}");
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          print("Auto retrieval timeout");
          isResendEnabled.value = true; // Enable resend after timeout
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An internal error occurred. Please try again.");
      print("Exception: $e");
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.isEmpty || otpController.text.length != 6) {
      Get.snackbar("Error", "Please enter a valid OTP");
      return;
    }
    customDialog();
    try {
      isLoading.value = true;
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading.value = false;
      Get.back(); // Close dialog
      showDoneStatus();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.back();
      handleAuthError(e);
    } catch (e) {
      isLoading.value = false;
      Get.back();
      Get.snackbar("Error", "An internal error occurred. Please try again.");
      print("Exception: $e");
    }
  }

  void handleAuthError(FirebaseAuthException ex) {
    isLoading.value = false;
    switch (ex.code) {
      case 'invalid-phone-number':
        Get.snackbar("Error", "Invalid phone number.");
        break;
      case 'too-many-requests':
        Get.snackbar("Error", "Too many requests. Please try again later.");
        break;
      case 'invalid-verification-code':
        Get.snackbar("Error", "Invalid OTP. Please try again.");
        break;
      case 'internal-error': // Handle internal error explicitly
        Get.snackbar("Verification Failed", "An internal error occurred. Please try again.");
        break;
      default:{
        print("Verification Failed : ${ex.message.toString()}");
        Get.snackbar("Verification Failed", ex.message ?? "Unknown error");
        break;
      }
    }
    print("FirebaseAuthException: ${ex.code.toString()}");
  }

  void startTimer() {
    remainingTime.value = 60; // Reset the timer
    isResendEnabled.value = false; // Disable resend initially
    timer?.cancel(); // Cancel any previous timers
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        isResendEnabled.value = true; // Enable resend OTP option after timer ends
      }
    });
  }

  // Function to resend OTP
  void resendOtp() {
    if (isResendEnabled.value) {
      verifyNumber(); // Resend OTP
    } else {
      Get.snackbar("Info", "Please wait until the timer ends.");
    }
  }

  void showDoneStatus() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Success',
      content: Column(
        children: [
          Image.asset('assets/successful.png', height: 100),
          const Text('OTP Verified Successfully!', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.offAllNamed(RoutesConstant.dashpage);
            Get.snackbar('Registration', 'User created successfully', backgroundColor: const Color(0xFF16F01E));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          child: const Text('Ok', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
      ],
    );
  }

  // Phone number validation
  bool validatePhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^[6-9]\d{9}$'); // Valid for Indian phone numbers
    return regex.hasMatch(phoneNumber);
  }
}
