import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  final String id;
  final GeoPoint pickupLocation;
  final GeoPoint dropLocation;
  final String vehicleType;
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
    required this.vehicleType,
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
      pickupLocation: data['pickup_location'] as GeoPoint? ?? GeoPoint(0, 0),
      dropLocation: data['drop_location'] as GeoPoint? ?? GeoPoint(0, 0),
      vehicleType: data['vehicleType'] as String? ?? '',
      status: data['status'] as String? ?? 'pending',
      amount: data['amount'] != null ? (data['amount'] as num).toDouble() : 0.0,
      clientName: data['clientName'] as String? ?? '',
      clientNumber: data['clientNumber'] as String? ?? '',
      pickupDate: data['pickupDate'] as String? ?? '', // Read as String
      timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
      notifiedVendors: List<String>.from(data['notifiedVendors'] ?? []),
      acceptedBy: data['acceptedBy'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickup_location': pickupLocation,
      'drop_location': dropLocation,
      'vehicleType': vehicleType,
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
  final GeoPoint pickupLocation;
  final GeoPoint dropLocation;
  final String vehicleType;
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
    required this.vehicleType,
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

    return Booking(
      id: doc.id,
      pickupLocation: data['pickupLocation'] as GeoPoint? ?? GeoPoint(0, 0),
      dropLocation: data['dropLocation'] as GeoPoint? ?? GeoPoint(0, 0),
      vehicleType: data['vehicleType'] as String? ?? '',
      status: data['status'] as String? ?? 'pending',
      amount: data['amount'] != null ? (data['amount'] as num).toDouble() : 0.0,
      clientName: data['clientName'] as String? ?? '',
      clientNumber: data['clientNumber'] as String? ?? '',
      pickupDate: data['pickupDate'] is Timestamp
          ? (data['pickupDate'] as Timestamp).toDate().toString()
          : data['pickupDate'] as String? ?? '',
      timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
      notifiedVendors: List<String>.from(data['notifiedVendors'] ?? []),
      acceptedBy: data['acceptedBy'] as String?,
      driverName: data['driverName'] as String?, // New field
      driverNumber: data['driverNumber'] as String?, // New field
      vehicleDetails: data['vehicleDetails'] as String?, // New field
      vehicleNumber: data['vehicleNumber'] as String?, // New field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickup_location': pickupLocation,
      'drop_location': dropLocation,
      'vehicleType': vehicleType,
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