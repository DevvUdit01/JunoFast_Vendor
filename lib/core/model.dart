// lib/Models/lead.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  final String id;
  final Map<String, dynamic> details;
  final String? acceptedBy;
  final String status;
  final GeoPoint pickupLocation; // Added GeoPoint
  final GeoPoint dropLocation;   // Added GeoPoint
  final String vehicleType;      // Added vehicleType
  final Timestamp timestamp;     // Added timestamp

  Lead({
    required this.id,
    required this.details,
    this.acceptedBy,
    required this.status,
    required this.pickupLocation, // Required GeoPoint
    required this.dropLocation,   // Required GeoPoint
    required this.vehicleType,    // Required vehicleType
    required this.timestamp,      // Required Timestamp
  });

  factory Lead.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Lead(
      id: doc.id,
      details: data['details'] ?? {},
      acceptedBy: data['acceptedBy'],
      status: data['status'] ?? 'pending',
      pickupLocation: data['pickup_location'] as GeoPoint, // Cast to GeoPoint
      dropLocation: data['drop_location'] as GeoPoint,     // Cast to GeoPoint
      vehicleType: data['vehicleType'] ?? '',              // Default empty string if null
      timestamp: data['timestamp'] as Timestamp,           // Cast to Timestamp
    );
  }
}
