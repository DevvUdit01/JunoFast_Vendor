import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/UIHelper/ui_helper.dart';
import 'forgotpasswordpage_controlller.dart';

class ForgotPasswprdPageView extends GetView<ForgotPasswordPageController> {
  const ForgotPasswprdPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    // Responsive padding and element sizing
    double imageWidth = screenSize.width * 0.5; // 50% of screen width
    double buttonPadding = screenSize.width * 0.2; // 20% of screen width

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password '),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Align headers to the start
          children: [
            Center(
              child: SizedBox(
                width: imageWidth,
                child: Image.asset('assets/jf_logo.png'),
              ),
            ),
            const SizedBox(height: 40),
           customTextField('Email', "Enter Email",TextInputType.emailAddress, Icons.email,controller.emailController),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.sendOTP();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Send OTP", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}