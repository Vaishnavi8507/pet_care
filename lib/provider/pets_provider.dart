import 'package:flutter/material.dart';
class PetsProvider with ChangeNotifier {
  int _currentIndex = 0;
  final List<String> _images = [
    'assets/images/dog.png',
    'assets/images/cat.png',
    'assets/images/rabbit.png',
    'assets/images/parrot.png'
  ];
  final List<String> _petTypes = ['Dog', 'Cat', 'Rabbit', 'Parrot'];

  int get currentIndex => _currentIndex;
  String get currentImage => _images[_currentIndex];
  String get selectedPetType => _petTypes[_currentIndex];

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

  void navigateToPetRegistration(BuildContext context) {
    Navigator.pushNamed(context, '/petRegister');
  }
}
