import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/signuppage/signup_binding.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';


class SignUpPageView extends GetView<SignUpPageBinding> {
  const SignUpPageView({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: imageWidth,
                child: Image.asset('assets/jf_logo.png'),
              ),
              const SizedBox(height: 40),
              customField("User Name", Icons.person, horizontalPadding),
              customField("Email", Icons.email, horizontalPadding),
              customField("Mobile Number", Icons.phone, horizontalPadding),
              customField("Password", Icons.lock, horizontalPadding),
              customField("Confirm Password", Icons.lock_open, horizontalPadding),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(RoutesConstant.formPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20), 
                Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 25, right: 25, bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 75,
                                  height: 45,
                                  child: InkWell(
                                      onTap: () {
                                       // controller.loginWithFacebook();
                                      },
                                      child: const Center(
                                          child: Icon(Icons.facebook,size: 40,)))),
                             
                               
                              SizedBox(
                                  width: 75,
                                  height: 45,
                                  child: InkWell(
                                      onTap: () {
                                       // controller.loginWithPhone();
                                      },
                                      child:
                                          const Center(child: Icon(Icons.phone,size: 32,)))),
                            ],
                          ),
                        ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Allready have an account? ", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(RoutesConstant.loginpage);
                        // Navigate to sign up page
                      },
                      child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ],
                ), 
                const SizedBox(height: 20,),
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
