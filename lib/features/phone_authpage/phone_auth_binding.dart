
import 'package:get/get.dart';
import 'package:junofast_vendor/features/formpage/formpage_controller.dart';
import 'phone_auth_controller.dart';

class PhoneAuthenticationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneAuthenticationController());
    Get.lazyPut(() => FormPageController());
  }
}