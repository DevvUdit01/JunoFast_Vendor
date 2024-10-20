
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'dash_board_contoller.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SizedBox(
      child: PersistentTabView(
      context, 
      screens: controller.buildScreen(),
      controller: controller.controller,
      items: controller.nabBarItem(),
      navBarStyle: NavBarStyle.style7,
      confineToSafeArea: true,
          backgroundColor: Colors.transparent, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          // popAllScreensOnTapOfSelectedTab: true,
          // popActionScreens: PopActionScreensType.all,
          // itemAnimationProperties:const ItemAnimationProperties( // Navigation Bar's items animation properties.
          //   duration: Duration(milliseconds: 200),
          //   curve: Curves.ease,
          // ),
          // screenTransitionAnimation:const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          //   animateTabTransition: true,
          //   curve: Curves.ease,
          //   duration: Duration(milliseconds: 200),
          // ),
          decoration: const NavBarDecoration(
            colorBehindNavBar: Color(0xFFEFECEC),
          ),
      ),
    ),
    
    );
}
}