
import 'package:get/get.dart';
import 'formpage_controller.dart';

class FormPageBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => FormPageController());
  }

}