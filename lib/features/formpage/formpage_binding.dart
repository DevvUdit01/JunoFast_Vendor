import 'package:get/get.dart';
import 'package:junofast_vendor/features/formpage/formpage_controller.dart';
import 'package:junofast_vendor/features/signuppage/signuppage_controller.dart';
import 'package:junofast_vendor/firebasServices/auth_services.dart';

import '../phone_authpage/phone_auth_controller.dart';

class FormPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPageController>(() => FormPageController());
    Get.lazyPut<SignUpPageController>(() => SignUpPageController());
    Get.lazyPut<PhoneAuthenticationController>(() => PhoneAuthenticationController());
  }
}