import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/ChangePassword.dart/changepassword_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          backgroundColor: Colors.orange, // Primary color for AppBar
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // Old Password Field
                Obx(() => TextFormField(
                      controller: controller.oldPasswordController,
                      obscureText: controller.passed1.value,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        labelStyle: const TextStyle(
                            color: Colors.orange), // Primary color for label
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange), // Primary color for focused border
                        ),
                        suffixIcon: IconButton(
                          icon: controller.passed1.value
                              ? const Icon(Icons.lock,
                                  color: Colors.orange) // Show lock icon when obscureText is true
                              : const Icon(Icons.remove_red_eye,
                                  color: Colors.orange), // Show person icon when obscureText is false
                          onPressed: () {
                            // Toggling between obscureText true/false
                            controller.passed1.value = !controller.passed1.value;
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 16.0),
                // New Password Field
                Obx(() => TextFormField(
                      controller: controller.newPasswordController,
                      obscureText: controller.passed2.value,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: const TextStyle(
                            color: Colors.orange), // Primary color for label
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange), // Primary color for focused border
                        ),
                        suffixIcon: IconButton(
                          icon: controller.passed2.value
                              ? const Icon(Icons.lock,
                                  color: Colors.orange) // Show lock icon when obscureText is true
                              : const Icon(Icons.remove_red_eye,
                                  color: Colors.orange), // Show person icon when obscureText is false
                          onPressed: () {
                            // Toggling between obscureText true/false
                            controller.passed2.value = !controller.passed2.value;
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 16.0),
                // Confirm New Password Field
                Obx(() => TextFormField(
                      controller: controller.conformPasswordController,
                      obscureText: controller.passed3.value,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        labelStyle: const TextStyle(
                            color: Colors.orange), // Primary color for label
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange), // Primary color for focused border
                        ),
                        suffixIcon: IconButton(
                          icon: controller.passed3.value
                              ? const Icon(Icons.lock,
                                  color: Colors.orange) // Show lock icon when obscureText is true
                              : const Icon(Icons.remove_red_eye,
                                  color: Colors.orange), // Show person icon when obscureText is false
                          onPressed: () {
                            // Toggling between obscureText true/false
                            controller.passed3.value = !controller.passed3.value;
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 24.0),

                // Submit Button with Loader
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.orange,) // Loader shown while loading
                    : ElevatedButton(
                        onPressed: () {
                          controller.isLoading.value = true;
                          if (formKey.currentState!.validate()) {
                            if (controller.newPasswordController.text.trim() ==
                                controller.conformPasswordController.text.trim()) {
                              controller.changePassword(
                                  controller.oldPasswordController.text.trim(),
                                  controller.newPasswordController.text.trim());
                            } else {
                              controller.isLoading.value = false;
                              Get.snackbar('Error', 'Please Correct NewPassword and Confirm Password.',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          }
                          else{
                            controller.isLoading.value = false;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Primary color for button
                          foregroundColor: Colors.white, // Secondary color for button text
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 12.0,
                          ), // Adjust button size according to text
                          textStyle: const TextStyle(
                            fontSize: 16, // Adjust the text size
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Change Password'),
                      )),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white, // Secondary color for background
      ),
    );
  }
}
