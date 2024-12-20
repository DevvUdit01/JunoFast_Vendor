
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/BookingPage/bookingpage_view.dart';
import 'package:junofast_vendor/features/PaymentPage/paymentpage_view.dart';
import 'package:junofast_vendor/features/settingspage/setting_page_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../HomePage/homepage_view.dart';


class DashBoardController extends GetxController{
 
  final controller =PersistentTabController();
   List<Widget> buildScreen (){
    return [
      const HomePageView(),
       BookingPageView(),
       const PaymentPageView(),      // const Center(child:  Text('setting page')),
      const SettingPageView(),
  
    ];
  }
   List<PersistentBottomNavBarItem> nabBarItem(){
    return [
       PersistentBottomNavBarItem(
      icon:const Icon(Icons.home,size: 30),
      title: ("Home"),
      activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: const Color(0xFF626161),
    ),
   
      PersistentBottomNavBarItem(
      icon:const Icon(Icons.book_online_sharp,size: 30),
      title: ("Booking"),
    activeColorPrimary: Colors.blue,
      inactiveColorPrimary: const Color(0xFF626161),
       activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
    ),

      PersistentBottomNavBarItem(
      icon:const Icon(Icons.currency_rupee_sharp,size: 30),
      title: ("Payment"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: const Color(0xFF626161),
       activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
    ),

      PersistentBottomNavBarItem(
      icon:const Icon(Icons.settings,size: 30),
      title: ("Setting"),
      activeColorPrimary: Colors.blue,
     inactiveColorPrimary: const Color(0xFF626161),
      activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
    ),
     
    ];
  }

  //   Future<void> setLoginValue() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool("isLogin", glb.isLogin.value);
  // }
  
}