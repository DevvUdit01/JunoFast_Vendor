import 'package:get/get.dart';
import 'package:junofast_vendor/features/BookingPage/booking_controller.dart';
import '../HomePage/homepage_controller.dart';
import '../settingspage/setting_page_controller.dart';
import 'dash_board_contoller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> HomePageController());
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => SettingPageController());
    Get.lazyPut(() => BookingPageController());
  }
}
