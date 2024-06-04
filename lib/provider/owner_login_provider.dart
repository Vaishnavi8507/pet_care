import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart/owner_authservice.dart';

class OwnerLoginProvider extends ChangeNotifier {
  String _ownerEmail = '';
  String _ownerPassword = '';
  bool _isOwnerPasswordVisible = false;

  String get ownerEmail => _ownerEmail;
  String get ownerPassword => _ownerPassword;
  bool get isOwnerPasswordVisible => _isOwnerPasswordVisible;

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setOwnerEmail(String email) {
    _ownerEmail = email;
    notifyListeners();
  }

  void setOwnerPassword(String password) {
    _ownerPassword = password;
    notifyListeners();
  }

  void toggleOwnerPasswordVisibility() {
    _isOwnerPasswordVisible = !_isOwnerPasswordVisible;
    notifyListeners();
  }

  Future<void> ownerLogin() async {
    if (_ownerEmail.isEmpty || _ownerPassword.isEmpty) {
      print("All fields are required!");
      return;
    }

    if (_ownerPassword.length < 8) {
      print("Password should be at least 8 characters");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_ownerEmail)) {
      print("Email should be in correct format!");
      return;
    }

    User? user = await _authService.signIn(_ownerEmail, _ownerPassword);

    if (user != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc('pet_owners')
          .collection('pet_owners')
          .doc(user.uid)
          .get();

      if (userDoc.exists && userDoc['role'] == 'owner') {
        print('User signed in successfully');
      } else {
        print('You are not authorized to log in as an owner');
        await FirebaseAuth.instance.signOut();
      }
    } else {
      print('Login failed');
    }
  }

  Future<void> ownerLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  void navigateToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgotPassword');
  }
}
