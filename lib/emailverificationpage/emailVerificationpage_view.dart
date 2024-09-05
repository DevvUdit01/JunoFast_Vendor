import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'emailVerificationpage_controlller.dart';

class EmailVerificationPageView extends GetView<EmailVerificationPageController> {
  const EmailVerificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    // Responsive padding and element sizing
    double horizontalPadding = screenSize.width * 0.05;
    double imageWidth = screenSize.width * 0.5; // 50% of screen width
    double buttonPadding = screenSize.width * 0.2; // 20% of screen width

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Center(
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: horizontalPadding),
                child: const Text('Personal info',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              ),
              customField("User Name", Icons.person, horizontalPadding),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                   // Get.toNamed(RoutesConstant.dashpage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text("Verify OTP", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget customField(String hintText, IconData iconData, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: horizontalPadding),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: Colors.black),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}
