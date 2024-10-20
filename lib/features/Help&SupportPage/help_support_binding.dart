
import 'package:get/get.dart';
import 'package:junofast_vendor/features/Help&SupportPage/help_support_controller.dart';

class HelpSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>HelpSupportController());
  }

}