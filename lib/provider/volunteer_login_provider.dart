import 'package:flutter/material.dart';

class VolunteerLoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void login({required String email, required String password}) {
    print('Email: $_email');
    print('Password: $_password');
  }
}
