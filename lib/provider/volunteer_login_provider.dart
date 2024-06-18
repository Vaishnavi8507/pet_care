import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/constants/snackbar.dart';
import 'package:pet_care/provider/get_volunteer_details_provider.dart';
import 'package:pet_care/services/auth_service.dart/owner_authservice.dart';
import 'package:pet_care/shared_pref_service.dart';
import 'package:provider/provider.dart';

class VolunteerLoginProvider extends ChangeNotifier {
  String _volunteerEmail = '';
  String _volunteerPassword = '';
  bool _isVolunteerPasswordVisible = false;

  bool _isVolunteerLoggedIn = false;

  String get volunteerEmail => _volunteerEmail;
  String get volunteerPassword => _volunteerPassword;
  bool get isVolunteerPasswordVisible => _isVolunteerPasswordVisible;
  bool get isVolunteerLoggedIn => _isVolunteerLoggedIn;

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SharedPreferencesService _prefsService = SharedPreferencesService();

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

  Future<void> volunteerLogin(BuildContext context) async {
    if (_volunteerEmail.isEmpty || _volunteerPassword.isEmpty) {
      showSnackBar(context, "All fields are required!");
      print("All fields are required!");
      return;
    }

    if (_volunteerPassword.length < 8) {
      showSnackBar(context, "Password should be at least 8 characters!");
      print("Password should be at least 8 characters");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_volunteerEmail)) {
      showSnackBar(context, "E-Mail should be in correct format");
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
        await _prefsService.setBool('isVolunteerLoggedIn', true);
        _isVolunteerLoggedIn = true;
        notifyListeners();
        print("Shared Value is $_isVolunteerLoggedIn");
         Provider.of<VolunteerDetailsGetterProvider>(context, listen: false)
          .loadVolunteerDetails();
        navigateToVolunteerDashboard(context);
        showSnackBar(context, "Sign In Successful!");
        print('User signed in successfully');
      } else {
        showSnackBar(context, "You are not authorized to log in as a volunteer");
        print('You are not authorized to log in as a volunteer');
        await FirebaseAuth.instance.signOut();
      }
    } else {
      showSnackBar(context, "Login Failed!");
      print('Login failed');
    }
  }

  Future<void> volunteerLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await _prefsService.setBool('isVolunteerLoggedIn', false);
    _isVolunteerLoggedIn = false;
    notifyListeners();
    navigateToSplashScreen(context);
  }

  Future<void> checkVolunteerLoginStatus() async {
    _isVolunteerLoggedIn = _prefsService.getBool('isVolunteerLoggedIn');
    notifyListeners();
  }
  
    void navigateToVolunteerReg(BuildContext context) {
    Navigator.pushNamed(context, '/volunteerReg');
  }

  void navigateToVolunteerDashboard(BuildContext context) {
    Navigator.pushNamed(context, '/volunteerHomeScreen');
  }

  void navigateToSplashScreen(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }
}
