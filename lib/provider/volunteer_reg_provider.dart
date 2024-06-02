import 'package:flutter/material.dart';

class VolunteerRegProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  String _phoneNo = '';
  String _age = '';
  String _occupation = '';
  bool _isPasswordVisible = false;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get phoneNo => _phoneNo;
  String get age => _age;
  String get occupation => _occupation;
  bool get isPasswordVisible => _isPasswordVisible;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
    notifyListeners();
  }

  void setAge(String age) {
    _age = age;
    notifyListeners();
  }

  void setOccupation(String occupation) {
    _occupation = occupation;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void signUp({required String name, required String email}) {
    print('Name: $_name');
    print('Email: $_email');
    print('Password: $_password');
    print('Phone No: $_phoneNo');
    print('Age: $_age');
    print('Occupation: $_occupation');
    // print('Owned Pet: $_ownedPet');
  }

  void navigateToVolunteerLogin(BuildContext context) {
    Navigator.pushNamed(context, '/volunteerLogin');
  }
}
