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
                            onPressed: () {
                              Get.toNamed(RoutesConstant.forgotPassword);
                            }, child: const Text('Forgot password?')),
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
                      fixedSize: Size(230, 55),
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
                        top: 45.0, left: 55, right: 55, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                                controller.loginWithGoogle();
                            },
                            child: const Center(
                              child: Image(image: AssetImage('assets/google.png'),width: 40,),
                              )),
                        InkWell(
                            onTap: () {
                              Get.toNamed(RoutesConstant.phoneAuth);
                              // controller.loginWithPhone();
                            },
                            child: const Center(
                                child: Icon(
                              Icons.phone,
                              size: 40,
                            ))),
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
                          Get.toNamed(RoutesConstant.signuppage2);
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
