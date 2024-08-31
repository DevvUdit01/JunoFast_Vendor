import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/Form_DetailsPage/formpage_controlller.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';

class FormPageView extends GetView<FormPageControlller> {
  const FormPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    // Responsive padding and element sizing
    double horizontalPadding = screenSize.width * 0.05;
    double imageWidth = screenSize.width * 0.5; // 50% of screen width
    double buttonPadding = screenSize.width * 0.2; // 20% of screen width

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // Align headers to the start
            children: [
              Center(
                child: SizedBox(
                  width: imageWidth,
                  child: Image.asset('assets/jf_logo.png'),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: horizontalPadding),
                child: const Text('Personal info',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              ),
              customField("User Name", Icons.person, horizontalPadding),
              customField("Email", Icons.email, horizontalPadding),
              customField("Mobile Number", Icons.phone, horizontalPadding),
              customField("Date of Birth", Icons.calendar_today, horizontalPadding),
              customField("Address", Icons.location_on, horizontalPadding),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: horizontalPadding),
                child: const Text('Vehicle info',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              ),
              customField("Vehicle Model", Icons.directions_car, horizontalPadding),
              customField("Year of Manufacture", Icons.calendar_today, horizontalPadding),
              customField("License Plate Number", Icons.credit_card, horizontalPadding),
              customField("Vehicle Identification Number (VIN)", Icons.vpn_key, horizontalPadding),
              customField("Vehicle Registration", Icons.assignment, horizontalPadding),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: horizontalPadding),
                child: const Text('Driver info',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              ),
              customField("License No.", Icons.perm_identity, horizontalPadding),
              customField("Expiry Date of License", Icons.calendar_today, horizontalPadding),
              customField("License Image", Icons.image, horizontalPadding),
              customField("Operating State", Icons.location_city, horizontalPadding),
              customField("National ID (Aadhar or ID)", Icons.perm_identity, horizontalPadding),              

              Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: horizontalPadding),
                child: const Text('Insurance Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              ),
              customField("Insurance Provider", Icons.business, horizontalPadding),
              customField("Policy Number", Icons.policy, horizontalPadding),
              customField("Expiry Date of Insurance", Icons.calendar_today, horizontalPadding),
              customField("Proof of Insurance", Icons.insert_drive_file, horizontalPadding),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutesConstant.dashpage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget customField(String hintText, IconData iconData, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: horizontalPadding),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: Colors.black),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}
