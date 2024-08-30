
import 'package:get/get.dart';
import 'phone_auth_controller.dart';

class PhoneAuthenticationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneAuthenticationController());
  }
}