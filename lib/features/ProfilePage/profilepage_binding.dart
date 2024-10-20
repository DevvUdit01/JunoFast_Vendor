import 'package:get/get.dart';
import 'package:junofast_vendor/features/ProfilePage/profilepage_controller.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ProfilePageController());
  }
}