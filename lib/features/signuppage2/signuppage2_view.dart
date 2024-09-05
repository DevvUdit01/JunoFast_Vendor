
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../UIHelper/ui_helper.dart';
import 'signuppage2_controller.dart';

class SignUpPageView2 extends GetView<SignUpPageController2> {
  const SignUpPageView2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Center(child: Text('Attach Your Vehicle')),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child: const Text(
                      'Are you a',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     Obx(() =>  Row(
                        children: [
                          Radio(
                            value: 'Fleet Owner',
                            groupValue: controller.role.value,
                            onChanged: (value) {
                              controller.selectRole(value!);
                            },
                          ),
                          const Text(' Fleet Owner'),
                        ],
                      ),),
                      Obx(() => Row(
                        children: [
                          Radio(
                            value: 'Packers & Movers',
                            groupValue: controller.role.value,
                            onChanged: (value) {
                              controller.selectRole(value!);
                            },
                          ),
                          const Text(' Packers & Movers'),
                        ],
                      ),),
                    ],
                  ),
                  customTextField("User Name", 'Enter Name', TextInputType.name, Icons.person, controller.nameController),
                  customTextField("Email", 'Enter Email', TextInputType.emailAddress, Icons.email, controller.emailController),
                  customTextField("Mobile Number", 'Enter Mobile Number', TextInputType.phone, Icons.phone, controller.phoneController),
                  customTextField("Firm", 'Enter Firm Name', TextInputType.text, Icons.business, controller.firmController),
                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child: Row(
                      children: [
                      Obx(() =>   Checkbox(
                          value: controller.registerFirm.value,
                          onChanged: (value) {
                            controller.registerFirm.value = value!;
                          },
                        ),),
                        const Expanded(
                          child: Text('  I don\'t have a registered firm'),
                        ),
                      ],
                    ),
                  ),
                  Padding(   
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Vehicles you own option',
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () => _showVehicleSelection(context),
                    ),
                  ),
                  customTextField("Password", 'Enter Password', TextInputType.text, Icons.lock, controller.passwordController),
                  customTextField("Address", 'Enter Address', TextInputType.text, Icons.location_on, controller.addressesController),
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child:  Text('Can do packing if required?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       Obx(() =>  Row(
                          children: [
                            Radio(
                              value: 'Yes',
                              groupValue: controller.packing.value,
                              onChanged: (value) {
                                controller.selectPacking(value!);
                              },
                            ),
                            const Text(' Yes'),
                          ],
                        ),),
                        const SizedBox(width: 20,),
                       Obx(() =>  Row(
                          children: [
                            Radio(
                              value: 'No',
                              groupValue: controller.packing.value,
                              onChanged: (value) {
                                controller.selectPacking(value!);
                              },
                            ),
                            const Text(' No'),
                          ],
                        ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  customTextField("Confirm Password", 'Enter Confirm Password', TextInputType.text, Icons.lock, controller.cpasswordController),
                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child: Row(
                      children: [
                        Obx(() => Checkbox(
                          value: controller.termCondition.value,
                          onChanged: (value) {
                            controller.termCondition.value = value!;
                          },
                        ),),
                        const Expanded(
                          child: Text('  I accept and agree to the Terms and Conditions'),
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
                      child: const Text('Join Us'),
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showVehicleSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Car'),
              onTap: () {
                // Handle car selection
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Bike'),
              onTap: () {
                // Handle bike selection
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Truck'),
              onTap: () {
                // Handle truck selection
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
