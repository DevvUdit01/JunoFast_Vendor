import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../UIHelper/ui_helper.dart';
import 'formpage_controller.dart';

class FormPageView extends GetView<FormPageController> {
  const FormPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get arguments passed from either Google Sign-in or phone Sign-in
    final Map<String, dynamic> userInfo = Get.arguments;
    
    // Only set the values once when the page is loaded
    if (controller.emailController.text.isEmpty) {
      // If signing in with Google
      controller.emailController.text = userInfo['email'] ?? '';
      controller.nameController.text = userInfo['name'] ?? '';
      controller.isGoogleLoging = true;
    }
    
    if (controller.phoneController.text.isEmpty) {
      // If signing in with Phone
      controller.isGoogleLoging = false;
      controller.phoneController.text = userInfo['phoneNumber'] ?? '';
    }

    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          backgroundColor: Colors.orange,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Center(child: Text('Attach Your Vehicle')),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: prefer_const_constructors
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: const Text(
                        'Are you a',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: 'Fleet Owner',
                                  groupValue: controller.role.value,
                                  onChanged: (value) {
                                    controller.selectRole(value!);
                                  },
                                ),
                                const Text('Fleet Owner'),
                              ],
                            ),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: 'Packers & Movers',
                                  groupValue: controller.role.value,
                                  onChanged: (value) {
                                    controller.selectRole(value!);
                                  },
                                ),
                                const Text('Packers & Movers'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    customTextField("User Name", 'Enter Name', TextInputType.name,Icons.person, controller.nameController),
                    controller.isGoogleLoging ? customTextField(
                        "Email",
                        'Enter Email',
                        TextInputType.emailAddress,
                        Icons.email,
                        controller.emailController)
                    :customTextFieldNoFilled(
                        "Email",
                        'Enter Email',
                        TextInputType.emailAddress,
                        Icons.email,
                        controller.emailController),
                      controller.isGoogleLoging ? customTextField(
                        "Mobile Number",
                        'Enter Mobile Number',
                        TextInputType.phone,
                        Icons.phone,
                        controller.phoneController)
                        : customTextFieldNoFilled(
                        "Mobile Number",
                        'Enter Mobile Number',
                        TextInputType.phone,
                        Icons.phone,
                        controller.phoneController),
                    customTextField("Firm", 'Enter Firm Name', TextInputType.text,
                        Icons.business, controller.firmController),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.registerFirm.value,
                              onChanged: (value) {
                                controller.registerFirm.value = value!;
                              },
                            ),
                          ),
                          const Expanded(
                            child: Text('  I don\'t have a registered firm'),
                          ),
                        ],
                      ),
                    ),
      
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: DropdownButtonFormField<String>(
                        value: controller.typeOfVehicleRequired,
                        items: const [
                          DropdownMenuItem(value: "Truck", child: Text("Truck")),
                          DropdownMenuItem(value: "Van", child: Text("Van")),
                          DropdownMenuItem(value: "Car", child: Text("Car")),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide
                                .none, // Default border (when not focused)
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          label: const Text('Vehicles your own option'),
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          // Set the border when focused (e.g., rounded with a solid border)
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors
                                  .transparent, // Change the color to your desired focus color
                              width: 2.0, // Change the thickness of the border
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          controller.typeOfVehicleRequired = value;
                        },
                      ),
                    ),
      
                    customTextField(
                        "Password",
                        'Enter Password',
                        TextInputType.text,
                        Icons.lock,
                        controller.passwordController),
                    customTextField(
                        "Address",
                        'Enter Address',
                        TextInputType.text,
                        Icons.location_on,
                        controller.addressController),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: Text(
                        'Can do packing if required?',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: 'Yes',
                                  groupValue: controller.packing.value,
                                  onChanged: (value) {
                                    controller.selectPacking(value!);
                                  },
                                ),
                                const Text('Yes'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: 'No',
                                  groupValue: controller.packing.value,
                                  onChanged: (value) {
                                    controller.selectPacking(value!);
                                  },
                                ),
                                const Text('No'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    customTextField(
                        "Confirm Password",
                        'Enter Confirm Password',
                        TextInputType.text,
                        Icons.lock,
                        controller.cpasswordController),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.termCondition.value,
                              onChanged: (value) {
                                controller.termCondition.value = value!;
                              },
                            ),
                          ),
                          const Expanded(
                            child: Text(
                                '  I accept and agree to the Terms and Conditions'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.checkValidation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(230, 55),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text("Submit",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    
                  const SizedBox(height: 260,),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}