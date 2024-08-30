
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junofast_vendor/features/BookingPage/booking_view.dart';
import 'package:junofast_vendor/features/settingspage/setting_page_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../HomePage/homepage_view.dart';


class DashBoardController extends GetxController{
 
  final controller =PersistentTabController();
   List<Widget> buildScreen (){
    return [
      const HomePageView(),
      const BookingPageView(),
      //const Center(child:  Text('Booking page')),
      const Center(child:  Text('Payment page')),
      // const Center(child:  Text('setting page')),
      const SettingPageView(),
  
    ];
  }
   List<PersistentBottomNavBarItem> nabBarItem(){
    return [
       PersistentBottomNavBarItem(
      icon:const Icon(Icons.home,size: 30,color: Colors.white,),
      title: ("Home"),
      activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: const Color(0xFFA7A6A6),
    ),
   
      PersistentBottomNavBarItem(
      icon:const Icon(Icons.book_online_sharp,size: 30,color: Colors.white,),
      title: ("Booking"),
    activeColorPrimary: Colors.blue,
      inactiveColorPrimary: const Color(0xFFA7A6A6),
       activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
    ),

      PersistentBottomNavBarItem(
      icon:const Icon(Icons.currency_rupee_sharp,size: 30,color: Colors.white,),
      title: ("Payment"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: const Color(0xFFA7A6A6),
       activeColorSecondary: Colors.white,
       inactiveColorSecondary: const Color(0xFFA7A6A6),
    ),

      PersistentBottomNavBarItem(
      icon:const Icon(Icons.person,size: 30,color: Colors.white,),
      title: ("Setting"),
      activeColorPrimary: Colors.blue,
     inactiveColorPrimary: const Color(0xFFA7A6A6),
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