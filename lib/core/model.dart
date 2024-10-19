import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  final String id;
  final String pickupLocation;
  final String dropLocation;
  final String leadPermission;
  final String status;
  final double amount;
  final String clientName;
  final String clientNumber;
  final String pickupDate; // Store as String
  final Timestamp timestamp;
  final List<String> notifiedVendors;
  final String? acceptedBy;

  Lead({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.leadPermission,
    required this.status,
    required this.amount,
    required this.clientName,
    required this.clientNumber,
    required this.pickupDate, // Updated to String
    required this.timestamp,
    required this.notifiedVendors,
    this.acceptedBy,
  });

  factory Lead.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Lead(
      id: doc.id,
      pickupLocation: data['pickupLocation'] ,
      dropLocation: data['dropLocation'],
      leadPermission: data['leadPermission'] ,
      status: data['status'] ,
      amount: data['amount'] ,
      clientName: data['clientName'],
      clientNumber: data['clientNumber'],
      pickupDate: data['pickupDate'] , // Read as String
      timestamp: data['timestamp'],
      notifiedVendors: List<String>.from(data['notifiedVendors']),
      acceptedBy: data['acceptedBy'] ,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickupLocation': pickupLocation,
      'dropLocation': dropLocation,
      'leadPermission': leadPermission,
      'status': status,
      'amount': amount,
      'clientName': clientName,
      'clientNumber': clientNumber,
      'pickupDate': pickupDate, // Store as String
      'timestamp': timestamp,
      'notifiedVendors': notifiedVendors,
      'acceptedBy': acceptedBy,
    };
  }
}


class Booking {
  final String id;
  final String pickupLocation;
  final String dropLocation;
  final String leadPermission;
  final String status;
  final double amount;
  final String clientName;
  final String clientNumber;
  final String pickupDate; // Store as String
  final Timestamp timestamp;
  final List<String> notifiedVendors;
  final String? acceptedBy;
  final String? driverName; // New field
  final String? driverNumber; // New field
  final String? vehicleDetails; // New field
  final String? vehicleNumber; // New field

  Booking({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.leadPermission,
    required this.status,
    required this.amount,
    required this.clientName,
    required this.clientNumber,
    required this.pickupDate, // Updated to String
    required this.timestamp,
    required this.notifiedVendors,
    this.acceptedBy,
    this.driverName, // New field
    this.driverNumber, // New field
    this.vehicleDetails, // New field
    this.vehicleNumber, // New field
  });

  factory Booking.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print( data['pickupLocation']);

    return Booking(
      id: doc.id,
      pickupLocation: data['pickupLocation'],
      dropLocation: data['dropLocation'] ,
      leadPermission: data['leadPermission'] ,
      status: data['status'] ,
      amount: data['amount'] ,
      clientName: data['clientName'],
      clientNumber: data['clientNumber'],
      pickupDate: data['pickupDate'] ,
      timestamp: data['timestamp'],
      notifiedVendors: List<String>.from(data['notifiedVendors']),
      acceptedBy: data['acceptedBy'] ,
      driverName: data['driverName'] , 
      driverNumber: data['driverNumber'] ,
      vehicleDetails: data['vehicleDetails'] , 
      vehicleNumber: data['vehicleNumber'] , 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickupLocation': pickupLocation,
      'dropLocation': dropLocation,
      'leadPermission': leadPermission,
      'status': status,
      'amount': amount,
      'clientName': clientName,
      'clientNumber': clientNumber,
      'pickupDate': pickupDate, // Store as String
      'timestamp': timestamp,
      'notifiedVendors': notifiedVendors,
      'acceptedBy': acceptedBy,
      'driverName': driverName, // New field
      'driverNumber': driverNumber, // New field
      'vehicleDetails': vehicleDetails, // New field
      'vehicleNumber': vehicleNumber, // New field
};
}
}