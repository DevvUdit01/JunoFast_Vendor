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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.orange,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: controller.loginKey, // Ensure this key is not reused elsewhere
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.1),
                    SizedBox(
                      width: screenSize.width * 0.8,
                      child: Image.asset('assets/jf_logo.png'),
                    ),
                    const SizedBox(height: 20),
                    // Custom Email Field
                    customTextField(
                      "Email",
                      'Enter Email',
                      TextInputType.emailAddress,
                      Icons.email,
                      controller.emailController,
                    ),
                    // Custom Password Field
                    customTextField(
                      "Password",
                      'Enter password',
                      TextInputType.text,
                      Icons.lock,
                      controller.passWordController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(RoutesConstant.forgotPassword);
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.checkValidation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        fixedSize: const Size(230, 55),
                        padding: EdgeInsets.symmetric(
                            horizontal: buttonPadding, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const Padding(
                       padding: EdgeInsets.only(top: 35.0, left: 55, right: 55),
                       child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Divider(
                                  thickness: 1.3,
                                color: Colors.black,
                              )),
                              Text(" or Login with ", style: TextStyle(fontSize: 16)),
                              Expanded(
                                  child: Divider(
                                    thickness: 1.3,
                                color: Colors.black,
                              )),
                            ],
                          ),
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
                              child: Image(
                                image: AssetImage('assets/google.png'),
                                width: 40,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RoutesConstant.phoneAuth,arguments: false);
                            },
                            child: const Center(
                              child: Icon(
                                Icons.phone,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesConstant.signuppage);
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}