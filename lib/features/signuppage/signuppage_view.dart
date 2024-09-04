import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/UIHelper/ui_helper.dart';
import 'package:junofast_vendor/features/signuppage/signuppage_controller.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';


class SignUpPageView extends GetView<SignUpPageController> {
  const SignUpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;
    
    // Responsive padding and element sizing
   // double horizontalPadding = screenSize.width * 0.05;
    double imageWidth = screenSize.width * 0.5; // 50% of screen width
    double buttonPadding = screenSize.width * 0.2; // 20% of screen width
    
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Form(
          key: controller.signupKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                SizedBox(
                  width: imageWidth,
                  child: Image.asset('assets/jf_logo.png'),
                ),
                const SizedBox(height: 40),
                customTextField("User Name", 'Enter Name',TextInputType.name,Icons.person, controller.nameController),
                customTextField("Email", 'Enter Email',TextInputType.name,Icons.email, controller.emailController),
                customTextField("Mobile Number",'Mobile Number',TextInputType.number, Icons.phone, controller.phoneController),
                customTextField("Password",'Password',TextInputType.text, Icons.lock, controller.passwordController),
                customTextField("Confirm Password",'Confirm Password',TextInputType.text,Icons.lock,controller.cpasswordController),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    controller.checkValidation();
                   // Get.toNamed(RoutesConstant.formPage);
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
                                  child: Image(image: AssetImage('assets/google.png'),width: 30,),
                                ))),
                               
                                 
                                SizedBox(
                                    width: 75,
                                    height: 45,
                                    child: InkWell(
                                        onTap: () {
                                        //  controller.loginWithPhone();
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
                           Get.offAllNamed(RoutesConstant.loginpage);
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
      ),
    );
  }
}
