
import 'package:flutter/material.dart';

import '../services/firestore_service/reminder_firestore.dart';

class ReminderProvider with ChangeNotifier {
  final ReminderService _reminderService = ReminderService();
  List<Map<String, dynamic>> _reminders = [];

  List<Map<String, dynamic>> get reminders => _reminders;

  Future<void> fetchReminders() async {
    try {
      _reminders = await _reminderService.getReminders();
      notifyListeners();
    } catch (e) {
      print('Error fetching reminders: $e');
      throw Exception('Failed to fetch reminders');
    }
  }

  Future<void> addReminder(String reminderText, int selectedCategoryIndex,
      DateTime finalDateTime) async {
    try {
      await _reminderService.addReminder(
        reminderText: reminderText,
        selectedCategoryIndex: selectedCategoryIndex,
        finalDateTime: finalDateTime,
      );
      await fetchReminders();
    } catch (e) {
      print('Error adding reminder: $e');
      throw Exception('Failed to add reminder');
    }
  }

  Future<void> deleteReminder(String reminderId) async {
    try {
      await _reminderService.deleteReminder(reminderId);
      await fetchReminders();
    } catch (e) {
      print('Error deleting reminder: $e');
      throw Exception('Failed to delete reminder');
    }
  }
}

