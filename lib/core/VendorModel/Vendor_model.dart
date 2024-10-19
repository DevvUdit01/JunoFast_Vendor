import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  late String name;
  late String email;
  late String mobileNumber;
  late String firm;
  late String password;
  late String conformPassword;
  late String address;
  late List<String> leadPermission; // Corrected to List<String>
  late String role;
  late String packing;
  late bool registerFirm;
  late List bookings;
  Map<String, dynamic> location;
  late String fcmToken;

  VendorModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.firm,
    required this.password,
    required this.conformPassword,
    required this.address,
    required this.leadPermission, // Expecting List<String> for permissions
    required this.role,
    required this.packing,
    required this.registerFirm,
    required this.bookings,
    required this.location,
    required this.fcmToken,
  });

  // Factory method to create VendorModel from Firestore DocumentSnapshot
  factory VendorModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return VendorModel(
      name: doc['name'],
      email: doc['email'],
      mobileNumber: doc['mobileNumber'],
      firm: doc['firm'],
      password: doc['password'],
      conformPassword: doc['conformPassword'],
      address: doc['address'],
      leadPermission: List<String>.from(doc['leadPermission']), // Ensure List<String>
      role: doc['role'],
      packing: doc['packing'],
      registerFirm: doc['registerFirm'],
      bookings: List.from(doc['bookings']),
      location: Map<String, dynamic>.from(doc['location']),
      fcmToken: doc['fcmToken'],
    );
  }

  // Convert VendorModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'firm': firm,
      'password': password,
      'conformPassword': conformPassword,
      'address': address,
      'leadPermission': leadPermission, // Ensure it saves as List<String>
      'role': role,
      'packing': packing,
      'registerFirm': registerFirm,
      'bookings': bookings,
      'location': location,
      'fcmToken': fcmToken,
    };
  }
}
