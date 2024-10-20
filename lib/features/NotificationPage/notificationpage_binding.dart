
import 'package:get/get.dart';
import 'package:junofast_vendor/features/NotificationPage/notificationPage_controller.dart';

class NotificationPageBinding extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(()=>NotificationPageController());
  }

}