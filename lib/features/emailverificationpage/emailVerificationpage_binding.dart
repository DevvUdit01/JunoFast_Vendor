
import 'package:get/get.dart';
import 'emailVerificationpage_controlller.dart';

class EmailVerificationPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>EmailVerificationPageController());
  }
  
}