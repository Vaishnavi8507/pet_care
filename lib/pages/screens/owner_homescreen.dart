import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Assuming you have a provider for navigation named NavigationProvider

class OwnerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String petName = arguments['petName'];
    final String petBreed = arguments['petBreed'];
    final String petAge = arguments['petAge'];
    final String? imagePath = arguments['imagePath'];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello Human',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // LightColors.textColor,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person, color: Colors.white),
                  backgroundColor: Colors.blue, // LightColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                if (imagePath != null)
                  CircleAvatar(
<<<<<<< HEAD
                    radius: 30,
=======
                    radius: 40,
>>>>>>> cbc957f4effc1a37531d16e72035f99369c664a9
                    backgroundImage: FileImage(File(imagePath)),
                  ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Colors.black, // LightColors.textColor,
<<<<<<< HEAD
                  radius: 30,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 20,
                    ),
=======
                  radius: 40,
                  child: IconButton(
                    icon: Icon(Icons.add),
>>>>>>> cbc957f4effc1a37531d16e72035f99369c664a9
                    onPressed: () {
                      // Navigating to pets page using the provider
                      Provider.of<NavigationProvider>(context, listen: false)
                          .navigateToPetsPage();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Pet Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // LightColors.textColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // LightColors.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  if (imagePath != null)
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(File(imagePath)),
                    ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: $petName',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black), // LightColors.textColor),
                        ),
                        Text(
                          'Breed: $petBreed',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black), // LightColors.textColor),
                        ),
                        Text(
                          'Age: $petAge',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black), // LightColors.textColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationProvider extends ChangeNotifier {
  void navigateToPetsPage() {
    // Navigate to pets page logic here
  }
}
