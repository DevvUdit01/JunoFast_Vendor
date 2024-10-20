import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/Help&SupportPage/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help & Support'),
          backgroundColor: Colors.orange, // Set the primary color to orange
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: <Widget>[
                // Name Field
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
      
                // Email Field
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
      
                // Feedback Field
                TextFormField(
                  controller: controller.helpSupportController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Your Help & Support Query',
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Provide Help & Support Query';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
      
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        // Process the bug report here
                       controller.sendFeedback(
                          'factshorts928@gmail.com', // Change to your support email
                          controller.nameController.text,
                          controller.emailController.text,
                          controller.helpSupportController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Feedback sent! Thank you.')),
                        );
                        controller.emailController.clear();
                        controller.nameController.clear();
                        controller.helpSupportController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Primary color
                      foregroundColor: Colors.white, // Secondary color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
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
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor:
            Colors.white, // Set the background (secondary) color to white
      ),
    );
  }
}
