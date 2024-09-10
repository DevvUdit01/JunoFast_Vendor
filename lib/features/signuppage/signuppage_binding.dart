
import 'package:get/get.dart';
import '../phone_authpage/phone_auth_controller.dart';
import 'signuppage_controller.dart';

class SignUpPageBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SignUpPageController());
    Get.lazyPut(() => PhoneAuthenticationController());
  }

}