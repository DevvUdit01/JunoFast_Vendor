import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
import '../../UIHelper/ui_helper.dart';
import 'login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    // Responsive padding and button size
    double horizontalPadding = screenSize.width * 0.05;
    double buttonPadding = screenSize.width * 0.15;

    return Scaffold(
      backgroundColor: Colors.orange,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: controller.loginKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height*0.1,),
                  SizedBox(
                    width: screenSize.width * 0.8,
                    child: Image.asset('assets/jf_logo.png'),
                  ),
                  const SizedBox(height: 20),
                  customTextField("Email", 'Enter Email',TextInputType.emailAddress,Icons.email, controller.emailController),
                  customTextField("Password", 'Enter password',TextInputType.text,Icons.lock, controller.passWordController),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {}, child: const Text('Forgot password')),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                     controller.checkValidation();
                      // Perform login action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                      horizontal: buttonPadding, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child:
                        const Text("Login", style: TextStyle(color: Colors.white)),
                  ),
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
                                    controller.loginWithFacebook();
                                },
                                child: const Center(
                                  child: Image(image: AssetImage('assets/google.png'),width: 30,),
                                  ))),
                        SizedBox(
                            width: 75,
                            height: 45,
                            child: InkWell(
                                onTap: () {
                                  Get.toNamed(RoutesConstant.phoneAuth);
                                  // controller.loginWithPhone();
                                },
                                child: const Center(
                                    child: Icon(
                                  Icons.phone,
                                  size: 32,
                                )))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(fontSize: 16)),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesConstant.signuppage);
                          // Navigate to sign up page
                        },
                        child: const Text("Sign Up",
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
