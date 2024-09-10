
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding customTextField(String label, String hintText, TextInputType inputType,
    IconData iconData, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
    child: TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData, color: Colors.black),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        label: Text(label),
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $hintText";
        }
        if (label == 'Email') {
          // Email validation pattern
          final RegExp emailRegex = RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
          );
          if (!emailRegex.hasMatch(value)) {
            return "Please enter a valid email address";
          }
        }
        return null;
      },
    ),
  );
}

 Future<dynamic> customDialog() => showDialog(context: Get.overlayContext!, builder: (context) => const Center(child: CircularProgressIndicator(),),);
