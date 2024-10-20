
import 'package:get/get.dart';
import 'package:junofast_vendor/features/ReportBugPage/reportBug_controller.dart';

class ReportBugBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ReportBugController());
  }

}