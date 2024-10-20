import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/routing/routes_constant.dart';
import 'setting_page_controller.dart';

class SettingPageView extends GetView<SettingPageController> {
  const SettingPageView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionHeader("GENERAL"),
              cartButton("Change Password", Icons.lock, Icons.arrow_forward_ios, () {
                Get.toNamed(RoutesConstant.changePassword);
              }),            
              cartButton("Notification", Icons.notifications_none, Icons.arrow_forward_ios, () {
                Get.toNamed(RoutesConstant.notificationPage);
              }),
              cartButton("Coupons", Icons.card_giftcard, Icons.arrow_forward_ios, () {

              }),
              cartButton("Logout", Icons.logout, Icons.arrow_forward_ios, () {
                controller.logOut();
              }),
              
              sectionHeader("FEEDBACK"),
              cartButton("Report a bug", Icons.report_problem_outlined, Icons.arrow_forward_ios, () {
              Get.toNamed(RoutesConstant.reportBugPage);
              }),
              cartButton("Help & Support", Icons.help, Icons.arrow_forward_ios, () {
               Get.toNamed(RoutesConstant.helpSupport);
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for section headers with orange color
  Widget sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.01),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Get.height * 0.03,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  }

  // Updated cartButton with white and orange theme
  Widget cartButton(String fieldName, IconData leadIcon, IconData trailIcon, VoidCallback voidCallback) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // White background for button
          borderRadius: BorderRadius.circular(Get.height * 0.01),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2), // Soft orange shadow
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          onTap: voidCallback,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Get.height * 0.01),
          ),
          leading: Icon(
            leadIcon,
            color: Colors.orange, // Orange icon color
          ),
          title: Text(
            fieldName,
            style: const TextStyle(
              color: Colors.black, // Text color
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            trailIcon,
            color: Colors.orange, // Orange trailing icon
          ),
        ),
      ),
    );
  }
}
