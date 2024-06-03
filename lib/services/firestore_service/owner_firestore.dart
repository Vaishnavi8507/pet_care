import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserDetails({
    required String userId,
    required String name,
    required String email,
    required String phoneNo,
    required String age,
    required String occupation,
    required String role,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc('pet_owners')
          .collection('pet_owners')
          .doc(userId)
          .set({
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'age': age,
        'occupation': occupation,
        'role': role,
      });
    } catch (e) {
      print("Error saving User Details $e");
    }
  }
}
