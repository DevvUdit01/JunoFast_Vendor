

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookingPageController extends GetxController{
  var bookings = [].obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchBooking();
    super.onInit();
  }

  fetchBooking() async{
   var snapshot = firebaseFirestore.collection('vendors').snapshots();
   print("all venders count ");
   print(snapshot.length);
  }
}