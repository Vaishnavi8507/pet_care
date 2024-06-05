import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreenProvider with ChangeNotifier {
  late AnimationController _animationController;
  late Animation<double> _animation;

  Animation<double> get animation => _animation;

  SplashScreenProvider(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    Timer(Duration(seconds: 3), () {
      _navigateToRegisterScreen();
    });
  }

  void _navigateToRegisterScreen() {
     notifyListeners();
  }

  void dispose() {
    _animationController.dispose();
  }
}