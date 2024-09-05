import 'package:get/get.dart';
import 'package:junofast_vendor/features/PaymentPage/paymentpage_controller.dart';

class PaymentPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPageController());
  }

}