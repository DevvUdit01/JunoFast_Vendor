
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class ReportBugController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  final TextEditingController screenshotController = TextEditingController();
  RxString filePath =''.obs;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filePath.value = result.files.single.path!;
      String fileName = result.files.single.name;
      screenshotController.text = fileName;
    }
  }

  Future<void> sendEmailWithAttachment(String recipientEmail, String name, String email, String description, String steps) async {
  final Email emailToSend = Email(
    body: 'Name: $name\nEmail: $email\nBug Description: $description\nSteps to Reproduce: $steps',
    subject: 'User Report a Bug On JunoFast',
    recipients: [recipientEmail],
    attachmentPaths: [filePath.value],  // Add the path to the attachment here
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(emailToSend);
    print('Email sent successfully');
  } catch (error) {
    print('Failed to send email: $error');
  }
  }
  
}
