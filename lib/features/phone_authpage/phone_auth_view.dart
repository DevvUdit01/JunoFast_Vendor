import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'phone_auth_controller.dart';

class PhoneAuthenticationView extends GetView<PhoneAuthenticationController> {
  const PhoneAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final isSignUp = Get.arguments;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Phone Authentication', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter your mobile number to receive an OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: controller.phoneKey,
                      child: TextFormField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone, color: Colors.black),
                          labelText: 'Mobile Number',
                          hintText: '1234567890',
                          prefixText: '+91 ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          }
                          if (value.length != 10) {
                            return 'Mobile number must have 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.checkValidate(isSignUp: isSignUp);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => controller.isCodeSent.value
                          ? Column(
                              children: [
                                Text(
                                  'Enter the OTP sent to your number:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                                  child: Text(
                                    "+91 ${controller.phoneController.text}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                Pinput(
                                  length: 6,
                                  controller: controller.otpController,
                                  defaultPinTheme: PinTheme(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Obx(
                                  () => Text(
                                    'Remaining Time: ${controller.remainingTime.value}s',
                                    style: const TextStyle(fontSize: 18, color: Colors.red),
                                  ),
                                ),
                                Obx(
                                  () => controller.remainingTime.value == 0
                                      ? TextButton(
                                         onPressed: () => controller.resendOtp(isSignUp: isSignUp),
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 246, 68, 255),
                                            textStyle: const TextStyle(fontSize: 16),
                                          ),
                                          child: const Text('Resend OTP'),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    controller.verifyOtp(isSignUp: isSignUp);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Verify OTP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}