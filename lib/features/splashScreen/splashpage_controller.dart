import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/core/globals.dart'as gbl;
import 'package:junofast_vendor/firebasServices/auth_services.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';


class SplashScreenController extends GetxController {
   @override
  void onInit() {
    super.onInit();
    // Preload image before the splash screen is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage("assets/jf_splashlogo.png"), Get.context!);
    });
  }

  @override
  void onReady() {
    super.onReady();
    chekLoginStatus();
  }

  void chekLoginStatus()async{
  // get login value
  await AuthService.getLoginValue();
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