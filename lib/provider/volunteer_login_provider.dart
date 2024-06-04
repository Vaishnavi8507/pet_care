import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart/owner_authservice.dart';
 
class VolunteerLoginProvider extends ChangeNotifier {
  String _volunteerEmail = '';
  String _volunteerPassword = '';
  bool _isVolunteerPasswordVisible = false;

  String get volunteerEmail => _volunteerEmail;
  String get volunteerPassword => _volunteerPassword;
  bool get isVolunteerPasswordVisible => _isVolunteerPasswordVisible;

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setVolunteerEmail(String email) {
    _volunteerEmail = email;
    notifyListeners();
  }

  void setVolunteerPassword(String password) {
    _volunteerPassword = password;
    notifyListeners();
  }

  void toggleVolunteerPasswordVisibility() {
    _isVolunteerPasswordVisible = !_isVolunteerPasswordVisible;
    notifyListeners();
  }

  Future<void> volunteerLogin() async {
    if (_volunteerEmail.isEmpty || _volunteerPassword.isEmpty) {
      print("All fields are required!");
      return;
    }

    if (_volunteerPassword.length < 8) {
      print("Password should be 8 characters");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_volunteerEmail)) {
      print("Email should be in correct format!");
      return;
    }
    
    User? user = await _authService.signIn(_volunteerEmail, _volunteerPassword);

    if (user != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc('volunteers')
          .collection('volunteers')
          .doc(user.uid)
          .get();

      if (userDoc.exists && userDoc['role'] == 'volunteer') {
        print('User signed in successfully');
      } else {
        print('You are not authorized to log in as a volunteer');
        await FirebaseAuth.instance.signOut();
      }
    } else {
      print('Login failed');
    }
  }

  Future<void> volunteerLogout() async {
    await FirebaseAuth.instance.signOut();
  }
}
