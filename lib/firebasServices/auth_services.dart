import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junofast_vendor/UIHelper/ui_helper.dart';
import '../core/VendorModel/Vendor_model.dart';

class AuthService {
  static final  FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
 static Future<User?> signUpWithEmailAndPassword(VendorModel vendor) async {
    try {
      customDialog();
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: vendor.email,
        password: vendor.password,
      );

      // Save vendor details to Firestore
      await _firestore.collection('vendors').doc(userCredential.user!.uid).set(vendor.toMap());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Login with email and password
  static  Future<User?> loginWithEmailAndPassword(String email, String password) async {

    try {
      customDialog();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Logout
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
