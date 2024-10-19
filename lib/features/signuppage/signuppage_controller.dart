import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/VendorModel/Vendor_model.dart';
import '../../firebasServices/auth_services.dart';

class SignUpPageController extends GetxController {
  final signupKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  var packing = ''.obs;
  String? role;
 late List<String> leadPermission = [];
  var termCondition = false.obs;
  var registerFirm = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize leadPermission if needed
  }

  void checkValidation() {
    if (signupKey.currentState != null) {
      // Check if formKey.currentState is not null
      if (signupKey.currentState!.validate()) {
        // Proceed if the form is valid
        if (packing.isEmpty) {
          Get.snackbar('Required', 'Check packing', backgroundColor: Colors.red);
        } else if (role == null || role!.isEmpty) {
          Get.snackbar('Required', 'Check role', backgroundColor: Colors.red);
        } else if (termCondition == false) {
          Get.snackbar('Required', 'Check term and condition', backgroundColor: Colors.red);
        } else if (registerFirm == false) {
          Get.snackbar('Required', 'Check register firm', backgroundColor: Colors.red);
        } else if (passwordController.text != cpasswordController.text) {
          Get.snackbar('Error', 'Please match password and confirm password', backgroundColor: Colors.red);
        } else {
          leadPermission.clear(); // Clear any previously added permissions

       if (role== 'Transport Agent') {
         leadPermission.add('Industrial Transportation');
       } 
       if (role == 'Packers & Movers') {
         leadPermission.addAll([
           'House Shifting',
           'PG Shifting',
           'Office Relocation',
           'Bike Carrier',
           'Parcel/Courier'
         ]);
       } 
       if (role == 'Field Officer') {
         leadPermission.add('Industrial Transportation');
       } 
       if (role == 'Car Carrier') {
         leadPermission.addAll([
           'Car Transportation',
           'Bike Transportation'
         ]);
       } 
       if (role == 'Bike Carrier') {
         leadPermission.add('Bike Transportation');
       }

          signUp();
          print('Valid form');
        }
      } else {
        print('Invalid form');
      }
    } else {
      print('Form key is null');
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
      leadPermission: leadPermission, // Assigning leadPermission directly
      role: role!,
      packing: packing.value,
      registerFirm: registerFirm.value,
      bookings: [], // Empty booking list initially
      location: {},
      fcmToken: '',
    );

    await AuthService.signUpWithEmailAndPassword(vendor);
  }

  String selectPacking(String selectedPacking) {
    packing.value = selectedPacking;
    return packing.value;
  }

  String selectRole(String selectedUser) {
    role = selectedUser;
    return role!;
  }

  void loginWithGoogle() async {
    print('SignUp with Google called');
    await AuthService.signUpWithGoogle();
  }
}
