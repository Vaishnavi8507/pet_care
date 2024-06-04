import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/services/auth_service.dart/owner_authservice.dart';
import 'package:pet_care/services/firestore_service/volunteer_firestore.dart';
 
class VolunteerRegistrationProvider extends ChangeNotifier {
  String _volunteerName = '';
  String _volunteerEmail = '';
  String _volunteerPassword = '';
  String _volunteerPhoneNo = '';
  String _volunteerAge = '';
  String _volunteerOccupation = '';
  bool _isVolunteerPasswordVisible = false;

  final String _volunteerRole = 'volunteer'; 
  final AuthService _authService = AuthService();
  final FireStoreService _fireStoreService = FireStoreService();

  String get volunteerName => _volunteerName;
  String get volunteerEmail => _volunteerEmail;
  String get volunteerPassword => _volunteerPassword;
  String get volunteerPhoneNo => _volunteerPhoneNo;
  String get volunteerAge => _volunteerAge;
  String get volunteerOccupation => _volunteerOccupation;
  bool get isPasswordVisible => _isVolunteerPasswordVisible;

  void setVolunteerName(String name) {
    _volunteerName = name;
    notifyListeners();
  }

  void setVolunteerEmail(String email) {
    _volunteerEmail = email;
    notifyListeners();
  }

  void setVolunteerPassword(String password) {
    _volunteerPassword = password;
    notifyListeners();
  }

  void setVolunteerPhoneNo(String phoneNo) {
    _volunteerPhoneNo = phoneNo;
    notifyListeners();
  }

  void setVolunteerAge(String age) {
    _volunteerAge = age;
    notifyListeners();
  }

  void setVolunteerOccupation(String occupation) {
    _volunteerOccupation = occupation;
    notifyListeners();
  }

  void toggleVolunteerPasswordVisibility() {
    _isVolunteerPasswordVisible = !_isVolunteerPasswordVisible;
    notifyListeners();
  }

  Future<void> volunteerSignUp() async {
    if (_volunteerName.isEmpty || _volunteerEmail.isEmpty || _volunteerPassword.isEmpty || _volunteerPhoneNo.isEmpty || _volunteerAge.isEmpty) {
      print("All fields are required!");
      return;
    }

    if (_volunteerPassword.length < 8) {
      print("Password should be at least 8 characters");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_volunteerEmail)) {
      print("Email should be in correct format!");
      return;
    }

    User? user = await _authService.signUp(_volunteerEmail, _volunteerPassword);

    if (user != null) {
      await _fireStoreService.saveVolunteerDetails(
        userId: user.uid,
        name: volunteerName,
        email: volunteerEmail,
        phoneNo: volunteerPhoneNo,
        age: volunteerAge,
        occupation: volunteerOccupation,
        role: _volunteerRole,
      );
      print('Volunteer signed up and details saved');
    }
  }

  void navigateToVolunteerLogin(BuildContext context) {
    Navigator.pushNamed(context, '/volunteerLogin');
  }
}
