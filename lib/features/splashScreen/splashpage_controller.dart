import 'dart:async';
import 'package:get/get.dart';
import 'package:junofast_vendor/core/globals.dart'as gbl;
import 'package:junofast_vendor/firebasServices/auth_services.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';


class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    chekLoginStatus();
  }

  void chekLoginStatus(){
  // get login value
   AuthService.getLoginValue();
  // splash screeen timer
    Timer(const Duration(seconds: 3), () {
      if (gbl.isLogin.value == true) {         
        Get.offAllNamed(RoutesConstant.dashpage);
       // FirebaseAuthService.getPfofile();
      } else {
        Get.offAllNamed(RoutesConstant.loginpage);
      }
    });
  }

}