
//import 'dart:async';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
//import 'package:uber_udit/routes/Routing/route_constant.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
      Timer(const Duration(seconds: 6), () {
        Get.toNamed(
        (FirebaseAuth.instance.currentUser != null) ? RoutesConstant.dashpage:RoutesConstant.loginpage,);
    });

   // chekLoginStatus();
  // FirebaseFireStoreService.fetchUserDocument();
  }

 // void chekLoginStatus(){
  // get login value
  //  FirebaseAuthService.getLoginValue();
  // // splash screeen timer
  //   Timer(const Duration(seconds: 3), () {
  //     if (gbl.isLogin.value == true) {         
  //       Get.offAllNamed(RouteConstant.deshpage);
  //       FirebaseAuthService.getPfofile();
  //     } else {
  //       Get.offAllNamed(RouteConstant.loginpage);
  //     }
  //   });
 // }

}
 
