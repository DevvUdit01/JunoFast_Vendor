import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  late String name;
  late String email;
  late String mobileNumber;
  late String firm;
  late String password;
  late String conformPassword;
  late String address;
  late String vehicleType;
  late String role;
  late String packing;
  late bool registerFirm;
  late List booking;

  VendorModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.firm,
    required this.password,
    required this.conformPassword,
    required this.address,
    required this.vehicleType,
    required this.role,
    required this.packing,
    required this.registerFirm,
    required this.booking,
  });

  factory VendorModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return VendorModel(
      name: doc['name'],
      email: doc['email'],
      mobileNumber: doc['mobileNumber'],
      firm: doc['firm'],
      password: doc['password'],
      conformPassword: doc['conformPassword'],
      address: doc['address'],
      vehicleType: doc['vehicleType'],
      role: doc['role'],
      packing: doc['packing'],
      registerFirm: doc['registerFirm'],
      booking: List.from(doc['booking']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'firm': firm,
      'password': password,
      'conformPassword': conformPassword,
      'address': address,
      'vehicleType': vehicleType,
      'role': role,
      'packing': packing,
      'registerFirm': registerFirm,
      'booking': booking,
    };
  }
}
