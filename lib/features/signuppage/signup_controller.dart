
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';

class SignUpPageController extends GetxController {
  RxBool isSet = true.obs;
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkValidation() {
    if (signupKey.currentState!.validate()) {
    Get.offAllNamed(RoutesConstant.homepage);
    }
    return;
  }

}