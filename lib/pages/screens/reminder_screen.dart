
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pet_care/widgets/components/textfield.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../constants/theme/light_colors.dart';
import '../../provider/reminder_provider.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final TextEditingController _reminderController = TextEditingController();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int selectedCategoryIndex = -1;
  List<bool> isSelected = List.generate(9, (index) => false);

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initSettings = InitializationSettings(
      android: android,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Fetch reminders on init
    Provider.of<ReminderProvider>(context, listen: false).fetchReminders();
  }

  void _addReminder(String reminderText) async {
    if (reminderText.isNotEmpty && selectedCategoryIndex != -1) {
      DateTime finalDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      try {
        // Save to Firebase
        await Provider.of<ReminderProvider>(context, listen: false)
            .addReminder(reminderText, selectedCategoryIndex, finalDateTime);

        _scheduleNotification(reminderText, finalDateTime);
        _reminderController.clear();
        setState(() {
          selectedCategoryIndex = -1;
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to save reminder. Please try again.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _scheduleNotification(
      String reminderText, DateTime scheduledTime) async {
    final tz.TZDateTime tzScheduledTime =
        tz.TZDateTime.from(scheduledTime, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      importance: Importance.max,
    );
    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      reminderText,
      tzScheduledTime,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void _showAddReminderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.4,
          maxChildSize: 1.0,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(9, (index) {
                            final icons = [
                              'assets/icons/walk.png',
                              'assets/icons/feed.png',
                              'assets/icons/play.png',
                              'assets/icons/sleep.png',
                              'assets/icons/vaccine.png',
                              'assets/icons/vet.png',
                              'assets/icons/timer.png',
                              'assets/icons/access_alarm.png',
                              'assets/icons/hourglass_empty.png',
                            ];

                            final labels = [
                              "Walk",
                              "Feed",
                              "Play",
                              "Sleep",
                              "Vaccine",
                              "Vet",
                              "Timer",
                              "Access Alarm",
                              "Hourglass Empty",
                            ];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Toggle isSelected for the tapped index
                                  isSelected[index] = !isSelected[index];
                                  if (isSelected[index]) {
                                    selectedCategoryIndex = index;
                                  } else {
                                    selectedCategoryIndex = -1;
                                  }
                                  print(
                                      'Selected Category Index: $selectedCategoryIndex');
                                });
                              },
                              child: Card(
                                elevation: 4.0,
                                color: selectedCategoryIndex == index
                                    ? LightColors.primaryColor.withOpacity(0.5)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                    color: selectedCategoryIndex == index
                                        ? LightColors.primaryColor
                                        : Colors.grey.shade800,
                                    width: 1.0,
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  width: 130,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        icons[index],
                                        width: 30,
                                        height: 40,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        labels[index],
                                        style: TextStyle(
                                          color: selectedCategoryIndex == index
                                              ? LightColors.primaryColor
                                              : LightColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 30),
                      MyTextField(
                        hintText: 'Enter the reminder',
                        obsText: false,
                        controller: _reminderController,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(16),
                        textStyle: TextStyle(color: LightColors.textColor),
                        fillColor: LightColors.backgroundColor,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 8),
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                    color: LightColors.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${_selectedDate.toLocal()}'.split(' ')[0],
                                  style: TextStyle(
                                    color: LightColors.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showDatePicker(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(width: 8),
                                Text(
                                  'Time:',
                                  style: TextStyle(
                                    color: LightColors.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  _selectedTime.format(context),
                                  style: TextStyle(
                                    color: LightColors.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (picked != null) {
                                  setState(() {
                                    _selectedTime = picked;
                                    print('Selected Time: $_selectedTime');
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print('Category Index: $selectedCategoryIndex');
                          print('Reminder Text: ${_reminderController.text}');
                          print('Selected Date: $_selectedDate');
                          print('Selected Time: $_selectedTime');

                          if (selectedCategoryIndex == -1 ||
                              _reminderController.text.isEmpty ||
                              _selectedDate == null ||
                              _selectedTime == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Incomplete Fields'),
                                  content: Text(
                                    'Please select all fields before saving the reminder.',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            _addReminder(_reminderController.text);
                            Navigator.of(context)
                                .pop(); // Close the bottom sheet
                          }
                        },
                        child: Text(
                          'Save Reminder',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddReminderBottomSheet(context);
              },
              child: Text(
                'Add Reminder',
                style: TextStyle(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<ReminderProvider>(
                builder: (context, reminderProvider, child) {
                  if (reminderProvider.reminders.isEmpty) {
                    return Center(
                      child: Text(
                        'No reminders found',
                        style: TextStyle(
                          color: LightColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: reminderProvider.reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = reminderProvider.reminders[index];
                      return ListTile(
                        leading: Icon(
                          Icons.watch_later_outlined,
                          color: LightColors.textColor,
                        ),
                        title: Text(reminder['reminderText']),
                        subtitle:
                            Text(reminder['timestamp'].toDate().toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await reminderProvider
                                .deleteReminder(reminder['id']);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
