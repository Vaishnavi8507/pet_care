import 'package:flutter/material.dart';
import 'package:pet_care/services/firestore_service/volunteer_firestore.dart';

class PetSitterProvider extends ChangeNotifier {
  final FireStoreService _fireStoreService = FireStoreService();
  List<Map<String, dynamic>> _volunteers = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get volunteers => _volunteers;
  bool get isLoading => _isLoading;

  Future<void> fetchVolunteers() async {
    _isLoading = true;
    notifyListeners();
    try {
      _volunteers = await _fireStoreService.getAllVolunteers();
    } catch (e) {
      print("Error fetching volunteers: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sortByPriceAsc() async {
    _isLoading = true;
    notifyListeners();
    try {
      _volunteers = await _fireStoreService.getAllVolunteersAsc();
    } catch (e) {
      print("Error fetching volunteers: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sortByPriceDsc() async {
    _isLoading = true;
    notifyListeners();
    try {
      _volunteers = await _fireStoreService.getAllVolunteersDsc();
    } catch (e) {
      print("Error fetching volunteers: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}
