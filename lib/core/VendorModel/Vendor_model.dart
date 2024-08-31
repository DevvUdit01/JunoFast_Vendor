
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  late String name;
  late String email;
  late String mobileNumber;
  late String password;
  late String address;

  late String vehicleType;
  late String yearOfManufacture;
  late String vehicleModel;
  late String licensePlateNumber;
  late String vehicleIdentificationNumber;
  late String vehicleRegistration;

  late String licenseNumber;
  late String expDateOfLicense;
  late String licenseImageUrl;  // Store the download URL
  late String operatingState;
  late String nationalId;

  late String insuranceProvider;
  late String expDateOfInsurance;
  late String policyNumber;
  late String proofOfInsurance;

  late List booking;

  VendorModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.password,
    required this.vehicleType,
    required this.yearOfManufacture,
    required this.vehicleModel,
    required this.licensePlateNumber,
    required this.vehicleIdentificationNumber,
    required this.vehicleRegistration,
    required this.licenseNumber,
    required this.expDateOfLicense,
    required this.licenseImageUrl,
    required this.operatingState,
    required this.nationalId,
    required this.insuranceProvider,
    required this.expDateOfInsurance,
    required this.policyNumber,
    required this.proofOfInsurance,
    required this.booking,
  });

  factory VendorModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return VendorModel(
      name: doc['name'],
      email: doc['email'],
      mobileNumber: doc['mobileNumber'],
      address: doc['address'],
      password: doc['password'],
      vehicleType: doc['vehicleType'],
      yearOfManufacture: doc['yearOfManufacture'],
      vehicleModel: doc['vehicleModel'],
      licensePlateNumber: doc['licensePlateNumber'],
      vehicleIdentificationNumber: doc['vehicleIdentificationNumber'],
      vehicleRegistration: doc['vehicleRegistration'],
      licenseNumber: doc['licenseNumber'],
      expDateOfLicense: doc['expDateOfLicense'],
      licenseImageUrl: doc['licenseImageUrl'], // Retrieve the download URL
      operatingState: doc['operatingState'],
      nationalId: doc['nationalId'],
      insuranceProvider: doc['insuranceProvider'],
      expDateOfInsurance: doc['expDateOfInsurance'],
      policyNumber: doc['policyNumber'],
      proofOfInsurance: doc['proofOfInsurance'],
      booking: doc['booking'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'address': address,
      'password': password,
      'vehicleType': vehicleType,
      'yearOfManufacture': yearOfManufacture,
      'vehicleModel': vehicleModel,
      'licensePlateNumber': licensePlateNumber,
      'vehicleIdentificationNumber': vehicleIdentificationNumber,
      'vehicleRegistration': vehicleRegistration,
      'licenseNumber': licenseNumber,
      'expDateOfLicense': expDateOfLicense,
      'licenseImageUrl': licenseImageUrl, // Save the download URL
      'operatingState': operatingState,
      'nationalId': nationalId,
      'insuranceProvider': insuranceProvider,
      'expDateOfInsurance': expDateOfInsurance,
      'policyNumber': policyNumber,
      'proofOfInsurance': proofOfInsurance,
      'booking': booking,
    };
  }
}
