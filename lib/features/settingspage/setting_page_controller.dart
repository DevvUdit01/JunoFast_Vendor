
import 'dart:ui';

import 'package:get/get.dart';
import 'package:junofast_vendor/firebasServices/auth_services.dart';
import '../../routing/routes_constant.dart';

class SettingPageController extends GetxController{
  void logOut() {
    AuthService.signOut();
    Get.snackbar('LogOut', 'LogOut successfull ',backgroundColor: Color(0xFF12FD1A));
    Get.offAllNamed(RoutesConstant.loginpage);

  }
  
}