import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/shared_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_care/constants/snackbar.dart';
import 'package:pet_care/services/auth_service.dart/owner_authservice.dart';
 
class OwnerLoginProvider extends ChangeNotifier {
  String _ownerEmail = '';
  String _ownerPassword = '';
  bool _isOwnerPasswordVisible = false;
  bool _isOwnerLoggedIn = false;

  String get ownerEmail => _ownerEmail;
  String get ownerPassword => _ownerPassword;
  bool get isOwnerPasswordVisible => _isOwnerPasswordVisible;
  bool get isOwnerLoggedIn => _isOwnerLoggedIn;

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SharedPreferencesService _prefsService = SharedPreferencesService();

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

  Future<void> ownerLogin(BuildContext context) async {
    if (_ownerEmail.isEmpty || _ownerPassword.isEmpty) {
      showSnackBar(context, "All fields are required!");
      print("All fields are required!");
      return;
    }

    if (_ownerPassword.length < 8) {
      showSnackBar(context, "Password should be at least 8 characters");
      print("Password should be at least 8 characters");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_ownerEmail)) {
      showSnackBar(context, "Email should be in correct format!");
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
        await _prefsService.setBool('isOwnerLoggedIn', true);
        _isOwnerLoggedIn = true;
        notifyListeners();
        print("Shared Value is $_isOwnerLoggedIn");
        print('User signed in successfully');
        navigateToOwnerDashboard(context);
        showSnackBar(context, "Sign in successful!");
                print("Shared Value is $_isOwnerLoggedIn");

      } else {
        showSnackBar(context, "You are not authorized to log in as an owner");
        print('You are not authorized to log in as an owner');
        await FirebaseAuth.instance.signOut();
      }
    } else {
      showSnackBar(context, "Login Failed!");
      print('Login failed');
    }
  }

  Future<void> ownerLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await _prefsService.setBool('isOwnerLoggedIn', false);
    _isOwnerLoggedIn = false;
    notifyListeners();
    navigateToSplashScreen(context);
  }

  Future<void> checkOwnerLoginStatus() async {
    _isOwnerLoggedIn = _prefsService.getBool('isOwnerLoggedIn');
    notifyListeners();
  }

  void navigateToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgotPassword');
  }

  void navigateToOwnerDashboard(BuildContext context) {
    Navigator.pushNamed(context, '/ownerHomeScreen');
  }

  void navigateToSplashScreen(BuildContext context) {
    Navigator.pushNamed(context, '/splashScreen');
  }
}
