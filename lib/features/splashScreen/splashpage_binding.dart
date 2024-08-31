import 'package:get/get.dart';

import 'splashpage_controller.dart';
class SplashScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}