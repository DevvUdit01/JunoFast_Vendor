import 'package:get/get.dart';
import 'package:junofast_vendor/features/Forget%20Password/forgotpasswordpage_controlller.dart';

class ForgotPasswprdPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ForgotPasswordPageController());
  }
  
}