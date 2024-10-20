import 'package:get/get.dart';
import 'package:junofast_vendor/features/ChangePassword.dart/changepassword_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ChangePasswordController());
  }
}