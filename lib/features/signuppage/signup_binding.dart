
import 'package:get/get.dart';
import 'signup_controller.dart';

class SignUpPageBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SignUpPageController());
  }

}