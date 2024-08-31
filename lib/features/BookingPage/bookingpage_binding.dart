import 'package:get/get.dart';
import 'bookingpage_controller.dart';

class BookingPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>BookingPageController());
  }

}