import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addReminder({
    required String reminderText,
    required int selectedCategoryIndex,
    required DateTime finalDateTime,
  }) async {
    User? user = _auth.currentUser;

    if (user != null) {
      await _firestore.collection('reminders').add({
        'userId': user.uid,
        'reminderText': reminderText,
        'categoryIndex': selectedCategoryIndex,
        'timestamp': finalDateTime,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('reminders')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => {
                'id': doc.id,
                'reminderText': doc['reminderText'],
                'categoryIndex': doc['categoryIndex'],
                'timestamp': (doc['timestamp'] as Timestamp).toDate(),
              })
          .toList();
    }
    return [];
  }

  Future<void> deleteReminder(String reminderId) async {
    await _firestore.collection('reminders').doc(reminderId).delete();
  }
}
