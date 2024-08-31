
import 'package:get/get.dart';
import 'package:junofast_vendor/features/Form_DetailsPage/formpage_controlller.dart';

class FormPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>FormPageControlller());
  }
  
}