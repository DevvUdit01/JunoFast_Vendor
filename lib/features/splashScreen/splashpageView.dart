import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splashpage_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: SizedBox(
            height: 200,
            child: controller.isImageLoaded
                ? Image.asset(
                    'assets/jf_splashlogo.png',
                    height: double.infinity,
                    width: double.infinity - 20,
                  )
                : const Icon(Icons.verified_user_outlined,size: 50,),  // Show a loader while the image is loading
          ),
        ),
      ),
    );
  }
}
