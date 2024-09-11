import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/VendorModel/Vendor_model.dart';
import '../../firebasServices/auth_services.dart';

class SignUpPageController extends GetxController {
//   RxBool isSet = true.obs;
  final signupKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  var packing = ''.obs;
  var role = ''.obs;
  var termCondition = false.obs;
  var registerFirm = false.obs;
  String? typeOfVehicleRequired;

  @override
  void onInit() {
    super.onInit();
  }

  void checkValidation() {
    if (signupKey.currentState != null) {
      // Check if formKey.currentState is not null
      if (signupKey.currentState!.validate()) {
        // Proceed if the form is valid
        if (packing.isEmpty) {
          Get.snackbar('Required','check packing',backgroundColor: Colors.red);
          print('check packing');
        } else if (role.isEmpty) {
          Get.snackbar('Required','check role',backgroundColor: Colors.red);
          print('check role');
        } else if (termCondition == false) {
          Get.snackbar('Required','check term and condition',backgroundColor: Colors.red);
          print('check term and condition');
        } else if (registerFirm == false) {
          Get.snackbar('Required','check register firm',backgroundColor: Colors.red);
          print('check register firm');
        }else if(passwordController.text != cpasswordController.text){
            Get.snackbar('Error','Please Match password and conform password',backgroundColor: Colors.red);
        }
         else {
          signUp();

          print('valid form');
        }
        // signUp();
        // Get.toNamed('/nextPage');  // Replace wit h your route
      } else {
        // Show error if the form is invalid
        print('Invalid form');
      }
    } else {
      // Handle the case where formKey.currentState is null
      print('form key null');
      return;
    }
  }
  void signUp() async {
  VendorModel vendor = VendorModel(
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    mobileNumber: mobileController.text.trim(),
    firm: firmController.text.trim(),
    password: passwordController.text.trim(),
    conformPassword: cpasswordController.text.trim(),
    address: addressController.text.trim(),
    vehicleType: typeOfVehicleRequired!,
    role: role.value,
    packing: packing.value,
    registerFirm: registerFirm.value,
    booking: [], // Empty booking list initially
  );

   await AuthService.signUpWithEmailAndPassword(vendor);
    
  }

  String selectPacking(String selectedPaking) {
    if (selectedPaking == 'Yes') {
      packing.value = selectedPaking;
      return packing.value;
    } else if (selectedPaking == 'No') {
      packing.value = selectedPaking;
      return packing.value;
    } else {
      return packing.value;
    }
  }

  String selectRole(String selectedUser) {
    if (selectedUser == 'Fleet Owner') {
      role.value = selectedUser;
      return role.value;
    } else if (selectedUser == 'Packers & Movers') {
      role.value = selectedUser;
      return role.value;
    } else {
      return role.value;
    }
  }

  void loginWithGoogle() async{
    print('signUp wiht google call');
    await AuthService.signUpWithGoogle();
  }

}