
import 'package:get/get.dart';
import 'signuppage_controller.dart';

class SignUpPageBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SignUpPageController());
  }

}