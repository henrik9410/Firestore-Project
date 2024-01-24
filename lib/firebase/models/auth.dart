import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      
      return user;
    } catch (e) {
      debugPrint("Error during anonymous sign-in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
  Future<void> deleteAnonymousAccount() async {
  try {
    await _auth.currentUser?.delete();
    debugPrint("Anonymous account deleted successfully!");
  } on FirebaseAuthException catch (e) {
    debugPrint("Error deleting anonymous account: ${e.message}");
  }
}
}
