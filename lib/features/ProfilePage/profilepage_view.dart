import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/ProfilePage/profilepage_controller.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.put(ProfilePageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: Colors.orange, // Primary color set to orange
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              // Username Field
              TextFormField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.orange), // Primary color applied to the label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color applied to the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color applied to focused border
                  ),
                ),
                enabled: controller.isEditing.value, // Editable only in editing mode
              ),
              const SizedBox(height: 16.0),

              // Email Field
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.orange), // Primary color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                enabled: false, // Non-editable field
              ),
              const SizedBox(height: 16.0),

              // Phone Number Field
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.orange), // Primary color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color
                  ),
                ),
                keyboardType: TextInputType.phone,
                enabled: controller.isEditing.value, // Editable only in editing mode
              ),
              const SizedBox(height: 16.0),
              
              TextFormField(
                controller: controller.addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.orange), // Primary color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange), // Primary color
                  ),
                ),
                keyboardType: TextInputType.phone,
                enabled: controller.isEditing.value, // Editable only in editing mode
              ),
              const SizedBox(height: 16.0),
              // Elevated Button (Edit/Save)
              Obx(() => Center(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        controller.isEditing.value ? Icons.save : Icons.edit,
                        size: 24.0,
                        color: Colors.white, // Secondary color white
                      ),
                      label: Text(
                        controller.isEditing.value ? "Save" : "Edit",
                        style: const TextStyle(color: Colors.white,fontSize: 18), // Secondary color white
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Primary color orange
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button size adjustment
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        if (controller.isEditing.value) {
                          // Save the changes if editing mode is on
                          // controller.updateUserInfo();
                        }
                        controller.isEditing.value =
                            !controller.isEditing.value; // Toggle edit mode
                      },
                    ),
                  )),
              // Optionally add more fields here
            ],
          ),
        ),
      ),
    );
  }
}
