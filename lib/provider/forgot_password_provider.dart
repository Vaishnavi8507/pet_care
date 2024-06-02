import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String _email = '';
  bool _isLoading = false;

  String get email => _email;
  bool get isLoading => _isLoading;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<void> resetPassword() async {
    if (_email.isEmpty) {
      // Handle empty email error
      print('Email is required');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 2));
      print('Password reset email sent to $_email');
    } catch (error) {
      print('Error resetting password: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}