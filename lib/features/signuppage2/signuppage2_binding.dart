
import 'package:get/get.dart';
import '../phone_authpage/phone_auth_controller.dart';
import 'signuppage2_controller.dart';

class SignUpPageBinding2 extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SignUpPageController2());
    Get.lazyPut(() => PhoneAuthenticationController());
  }

}