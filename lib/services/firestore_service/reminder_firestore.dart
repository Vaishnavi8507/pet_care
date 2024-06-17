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
      try {
        await _firestore
            .collection('reminders')
            .doc(user.uid)
            .collection('user_reminders')
            .add({
          'reminderText': reminderText,
          'categoryIndex': selectedCategoryIndex,
          'timestamp': finalDateTime,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Reminder added successfully');
      } catch (e) {
        print('Error adding reminder: $e');
        throw Exception('Failed to add reminder');
      }
    }
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    User? user = _auth.currentUser;
    List<Map<String, dynamic>> reminders = [];

    if (user != null) {
      try {
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('reminders')
            .doc(user.uid)
            .collection('user_reminders')
            .orderBy('timestamp', descending: true)
            .get();

        reminders = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'reminderText': doc['reminderText'],
            'categoryIndex': doc['categoryIndex'],
            'timestamp': (doc['timestamp'] as Timestamp).toDate(),
          };
        }).toList();

        print('Reminders fetched successfully');
      } catch (e) {
        print('Error getting reminders: $e');
        throw Exception('Failed to fetch reminders');
      }
    }
    return reminders;
  }

  Future<void> deleteReminder(String reminderId) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await _firestore
            .collection('reminders')
            .doc(user.uid)
            .collection('user_reminders')
            .doc(reminderId)
            .delete();

        print('Reminder deleted successfully');
      } catch (e) {
        print('Error deleting reminder: $e');
        throw Exception('Failed to delete reminder');
      }
    }
  }
}
