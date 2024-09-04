
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding customTextField(String lable,String hintText,TextInputType inputType,
    IconData iconData, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
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
          label:  Text(lable),
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
      ),
      validator: (value) {
        if (value == '') {
          return "Please $hintText";
        }
        return null;
      },
    ),
  );
}

 Future<dynamic> customDialog() => showDialog(context: Get.overlayContext!, builder: (context) => const Center(child: CircularProgressIndicator(),),);
