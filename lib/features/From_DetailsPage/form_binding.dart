
import 'package:get/get.dart';
import 'package:junofast_vendor/features/From_DetailsPage/form_controlller.dart';

class FormPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>FormPageControlller());
  }
  
}