import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
import '../../UIHelper/ui_helper.dart';
import 'signuppage_controller.dart';

class SignUpPageView extends GetView<SignUpPageController> {
  const SignUpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
         resizeToAvoidBottomInset: false,
          backgroundColor: Colors.orange,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Center(child: Text('fill your all details')),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.signupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: prefer_const_constructors
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: const Text(
                        'tell your role ...',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
                      child:   DropdownButtonFormField<String>(
                  value: controller.role,
                  items: const [
                    DropdownMenuItem(value: "Transport Agent", child: Text("Transport Agent")),
                    DropdownMenuItem(value: "Packers & Movers", child: Text("Packers & Movers")),
                    DropdownMenuItem(value: "Field Officer", child: Text("Field Officer")),
                    DropdownMenuItem(value: "Car Carrier", child: Text("Car Carrier")),
                    DropdownMenuItem(value: "Bike Carrier", child: Text("Bike Carrier")),
                  ],
                  onChanged: (value) {
                    controller.role = value!;
                  },
                  decoration: InputDecoration(
                    labelText: "Type of Vendor ",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                    ),
                    customTextField("User Name", 'Enter Name', TextInputType.name,
                        Icons.person, controller.nameController),
                    customTextField(
                        "Email",
                        'Enter Email',
                        TextInputType.emailAddress,
                        Icons.email,
                        controller.emailController),
                    customTextField(
                        "Mobile Number",
                        'Enter Mobile Number',
                        TextInputType.phone,
                        Icons.phone,
                        controller.mobileController),
                    customTextField("Firm name", 'Enter Firm Name', TextInputType.text,
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
      
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    //   child: DropdownButtonFormField<String>(
                    //     value: controller.typeOfVehicleRequired,
                    //     items: const [
                    //       DropdownMenuItem(value: "Truck", child: Text("Truck")),
                    //       DropdownMenuItem(value: "Van", child: Text("Van")),
                    //       DropdownMenuItem(value: "Car", child: Text("Car")),
                    //     ],
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide
                    //             .none, // Default border (when not focused)
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white.withOpacity(0.8),
                    //       label: const Text('Vehicles your own option'),
                    //       hintStyle: const TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.grey,
                    //       ),
                    //       // Set the border when focused (e.g., rounded with a solid border)
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: const BorderSide(
                    //           color: Colors
                    //               .transparent, // Change the color to your desired focus color
                    //           width: 2.0, // Change the thickness of the border
                    //         ),
                    //       ),
                    //     ),
                    //     onChanged: (value) {
                    //       controller.typeOfVehicleRequired = value;
                    //     },
                    //   ),
                    // ),

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
                        "Password",
                        'Enter Password',
                        TextInputType.text,
                        Icons.lock,
                        controller.passwordController),
                        
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
                          // Perform login action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: Size(230, 55),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text("Sign Up",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),

                   const Padding(
                     padding: EdgeInsets.only(top: 35.0, left: 55, right: 55),
                     child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Divider(
                                  thickness: 1.3,
                                  color: Colors.black,
                              ) ),
                              Text(" or Sign Up with ", style: TextStyle(fontSize: 16)),
                              Expanded(
                                  child: Divider(
                                  thickness: 1.3,
                                  color: Colors.black,
                              ) ),
                            ],
                          ),
                   ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 35.0, left: 55, right: 55, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                controller.loginWithGoogle();
                              },
                              child: const Center(
                                child: Image(
                                  image: AssetImage('assets/google.png'),
                                  width: 40,
                                ),
                              )),
                          InkWell(
                              onTap: () {
                                Get.toNamed(RoutesConstant.phoneAuth,arguments: 1);
                              },
                              child: const Center(
                                  child: Icon(
                                Icons.phone,
                                size: 40,
                              ))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ",
                            style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed(RoutesConstant.loginpage);
                            // Navigate to sign up page
                          },
                          child: const Text("Login",
                              style: TextStyle(fontSize: 16, color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}