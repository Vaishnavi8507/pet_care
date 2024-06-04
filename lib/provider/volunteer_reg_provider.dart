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
  String _volunteerAboutMe = '';
  bool _prefersCat = false;
  bool _prefersDog = false;
  bool _prefersBird = false;
  bool _prefersRabbit = false;
  bool _prefersOthers = false;
  bool _providesHomeVisits = false;
  bool _providesDogWalking = false;
  bool _providesHouseSitting = false;
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
  String get volunteerAboutMe => _volunteerAboutMe;
  bool get prefersCat => _prefersCat;
  bool get prefersDog => _prefersDog;
  bool get prefersBird => _prefersBird;
  bool get prefersRabbit => _prefersRabbit;
  bool get prefersOthers => _prefersOthers;
  bool get providesHomeVisits => _providesHomeVisits;
  bool get providesDogWalking => _providesDogWalking;
  bool get providesHouseSitting => _providesHouseSitting;
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

  void setVolunteerAboutMe(String aboutMe) {
    _volunteerAboutMe = aboutMe;
    notifyListeners();
  }

  void setPrefersCat(bool value) {
    _prefersCat = value;
    notifyListeners();
  }

  void setPrefersDog(bool value) {
    _prefersDog = value;
    notifyListeners();
  }

  void setPrefersBird(bool value) {
    _prefersBird = value;
    notifyListeners();
  }

  void setPrefersRabbit(bool value) {
    _prefersRabbit = value;
    notifyListeners();
  }

  void setPrefersOthers(bool value) {
    _prefersOthers = value;
    notifyListeners();
  }

  void setProvidesHomeVisits(bool value) {
    _providesHomeVisits = value;
    notifyListeners();
  }

  void setProvidesDogWalking(bool value) {
    _providesDogWalking = value;
    notifyListeners();
  }

  void setProvidesHouseSitting(bool value) {
    _providesHouseSitting = value;
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
    if (_volunteerName.isEmpty ||
        _volunteerEmail.isEmpty ||
        _volunteerPassword.isEmpty ||
        _volunteerPhoneNo.isEmpty ||
        _volunteerAge.isEmpty) {
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
        aboutMe: volunteerAboutMe,
        prefersCat: prefersCat,
        prefersDog: prefersDog,
        prefersBird: prefersBird,
        prefersRabbit: prefersRabbit,
        prefersOthers: prefersOthers,
        providesHomeVisits: providesHomeVisits,
        providesDogWalking: providesDogWalking,
        providesHouseSitting: providesHouseSitting,
        role: _volunteerRole,
      );
      print('Volunteer signed up and details saved');
    }
  }

  void navigateToVolunteerLogin(BuildContext context) {
    Navigator.pushNamed(context, '/volunteerLogin');
  }

  void navigateToVolunteerReg2(BuildContext context) {
    Navigator.pushNamed(context, '/volunteerRegister2');
  }
}
