import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/services/firestore_service/pet_register.dart';
class PetsDetailsGetterProvider extends ChangeNotifier {
  final FireStoreService _fireStoreService = FireStoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isDataLoaded = false;
  bool get isDataLoaded => _isDataLoaded;

  List<Map<String, dynamic>> _pets = [];

  List<Map<String, dynamic>> get pets => _pets;

  PetsDetailsGetterProvider() {
    loadPets();
  }

  Future<void> loadPets() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Clear previous data when loading pets for a new user
        _pets.clear();

        _pets = await _fireStoreService.getPets(user.email!);
        _isDataLoaded = true; // Set isDataLoaded to true when data is loaded
        notifyListeners(); // Notify listeners after loading pets
        print("Pets data loaded successfully:");
        print(_pets); // Print the entire pets data
      } catch (e) {
        print("Error loading pets data: $e");
      }
    } else {
      print("No user logged in.");
    }
  }

  void clearData() {
    _pets = [];
    _isDataLoaded = false;
    notifyListeners();
  }
}
