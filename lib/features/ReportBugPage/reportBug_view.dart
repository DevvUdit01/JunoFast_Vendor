import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/ReportBugPage/reportBug_controller.dart';

class ReportBugView extends GetView<ReportBugController> {
  const ReportBugView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Report a Bug'),
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
      
                // Bug Description Field
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Bug Description',
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the bug';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
      
                // Steps to Reproduce Field
                TextFormField(
                  controller: controller.stepsController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Steps to Reproduce',
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide the steps to reproduce the bug';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
      
                // Screenshot/File Attachment
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.screenshotController,
                        decoration: const InputDecoration(
                          labelText: 'Attach Screenshot or File (Optional)',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () {
                        controller.pickFile(); // Logic for picking a file
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
      
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                       // Process the bug report here
                        controller.sendEmailWithAttachment(
                          "factshorts928@gmail.com",
                           controller.nameController.text,
                            controller.emailController.text,
                             controller.descriptionController.text,
                              controller.stepsController.text,
                          );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bug report submitted!')),
                        );
                        controller.emailController.clear();
                        controller.nameController.clear();
                        controller.descriptionController.clear();
                        controller.stepsController.clear();
                        controller.screenshotController.clear();
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
                    child: const Text('Submit Report'),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white, // Set the secondary color (white) for the background
      ),
    );
  }
}
