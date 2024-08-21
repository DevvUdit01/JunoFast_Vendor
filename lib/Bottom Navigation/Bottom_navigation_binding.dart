import 'package:get/get.dart';
import 'package:junofast_vendor/Bottom%20Navigation/bottom_navigation_controller.dart';
import 'package:junofast_vendor/Dashboard/dashboard_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut(() => DashboardController());
  }
}
