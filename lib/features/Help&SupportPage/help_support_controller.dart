import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';


class HelpSupportController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController helpSupportController = TextEditingController();

  Future<void> sendFeedback(String recipientEmail, String name, String email,
      String feedback) async {
     final Email emailToSend = Email(
    body: 'Name: $name\nEmail: $email\nFeedback: $feedback',
    subject: 'User Help & Support JunoFast',
    recipients: [recipientEmail],
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
