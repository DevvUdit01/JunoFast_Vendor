import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/VendorModel/Vendor_model.dart';
import '../../firebasServices/auth_services.dart';

class FormPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  
  var packing = ''.obs;
  var role = ''.obs;
  var termCondition = false.obs;
  var registerFirm = false.obs;
  late bool isGoogleLoging;
  String? typeOfVehicleRequired;

  @override
  void onInit() {
    super.onInit();
    // If arguments are passed (e.g., Google sign-in info), populate fields
    Map<String, dynamic>? arguments = Get.arguments;
    if (arguments != null) {
      emailController.text = arguments['email'] ?? '';
      nameController.text = arguments['name'] ?? '';
    }
  }

  void checkValidation() {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        if (packing.isEmpty) {
          Get.snackbar('Required', 'Check packing', backgroundColor: Colors.red);
        } else if (role.isEmpty) {
          Get.snackbar('Required', 'Check role', backgroundColor: Colors.red);
        } else if (!termCondition.value) {
          Get.snackbar('Required', 'Accept terms and conditions', backgroundColor: Colors.red);
        } else if (!registerFirm.value) {
          Get.snackbar('Required', 'Confirm firm registration', backgroundColor: Colors.red);
        } else if (passwordController.text != cpasswordController.text) {
          Get.snackbar('Error', 'Passwords do not match', backgroundColor: Colors.red);
        } else {
          signUp();
        }
      } else {
        print('Invalid form');
      }
    } else {
      print('form key is null');
    }
  }

  void signUp() async {
    VendorModel vendor = VendorModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobileNumber: phoneController.text.trim(),
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

    // Return the vendor model to the previous page
    Get.back(result: vendor);
  }

  String selectPacking(String selectedPacking) {
    packing.value = selectedPacking;
    return packing.value;
  }

  String selectRole(String selectedUser) {
    role.value = selectedUser;
    return role.value;
  }

  void loginWithGoogle() async {
    await AuthService.signUpWithGoogle();
  }
}