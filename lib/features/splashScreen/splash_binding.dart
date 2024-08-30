import 'package:get/get.dart';

import 'splash_controller.dart';
class SplashScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}