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
    return;
  }

  Future<void> verifyNumber() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text.trim()}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
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
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      print("Exception: $e");
    }
  }

  Future<void> verifyOtp() async {
    customDialog();
    try {
      isLoading.value = true;
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading.value = false;
      Get.back();
      showDoneStatus();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.back();
      handleAuthError(e);
    } catch (e) {
      isLoading.value = false;
      Get.back();
      Get.snackbar("Error", e.toString());
      print("Exception: $e");
    }
  }

  void handleAuthError(FirebaseAuthException ex) {
    if (ex.code == 'too-many-requests') {
      Get.snackbar("Error", "Too many requests. Please try again later.");
    } else {
      Get.snackbar("Verification Failed", ex.message ?? "Unknown error");
    }
    print("FirebaseAuthException: ${ex.code}");
  }

  void startTimer() {
    remainingTime.value = 60; // Reset the timer
    timer?.cancel(); // Cancel any previous timers
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
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
            Get.snackbar('Registration', 'Create User Successfully', backgroundColor: const Color(0xFF16F01E));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          child: const Text('Ok', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
      ],
    );
  }
}
