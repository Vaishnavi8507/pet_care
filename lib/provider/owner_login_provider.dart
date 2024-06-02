import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/services/auth_service.dart/owner_authservice.dart';

class OwnerLoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;

   final AuthService _authService = AuthService();

 

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

 Future<void> login() async {

  if (
        _email.isEmpty ||
        _password.isEmpty 
       ) {
 
      print("All fields are required!");
       
      return;
    }

    if (_password.length < 8) {
      print("Password should be 8 characters");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_email)) {
       print("Email should be in correct format! ");
       return;
    }
    User? user = await _authService.signIn(_email, _password);

    if(user != null){
      print('User signed in successfully');
     } else {
      print('Login failed');
     }
  }

  void navigateToOwnerLogin(BuildContext context) {
    Navigator.pushNamed(context, '/ownerLogin');
  }
}