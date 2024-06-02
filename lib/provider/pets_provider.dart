import 'package:flutter/material.dart';

class PetsProvider with ChangeNotifier {
  int _currentIndex = 0;
  final List<String> _images = [
    'assets/images/dogo.png',
    'assets/images/cat.png',
    'assets/images/rabbit.png',
  ];

  int get currentIndex => _currentIndex;
  String get currentImage => _images[_currentIndex];

  void nextImage() {
    if (_currentIndex < _images.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousImage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void navigateToPets(BuildContext context) {
    Navigator.pushNamed(context, '/pets');
  }
}
