import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/constants/theme/light_colors.dart';
import 'package:pet_care/pages/screens/reminder_screen.dart';
import 'package:pet_care/provider/get_petData_provider.dart';
import 'package:pet_care/provider/owner_dashboard_provider.dart';
import 'package:pet_care/provider/reminder_provider.dart';
import 'package:provider/provider.dart';

class OwnerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final petsDetailsProvider = Provider.of<PetsDetailsGetterProvider>(context);
    final ownerDashboardProvider = Provider.of<OwnerDashboardProvider>(context);

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
                  'Hello Hooman',
                  //textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ownerEditProfile');
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person, color: Colors.black),
                    backgroundColor: Colors.blueGrey.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Consumer<PetsDetailsGetterProvider>(
                      builder: (context, petsDetailsProvider, child) {
                        return petsDetailsProvider.isDataLoaded
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: petsDetailsProvider.pets.length,
                                itemBuilder: (context, index) {
                                  final pet = petsDetailsProvider.pets[index];
                                  return GestureDetector(
                                    onTap: () {
                                      ownerDashboardProvider
                                          .selectPetIndex(index);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: pet['imagePath'] !=
                                                null
                                            ? FileImage(File(pet['imagePath']))
                                            : AssetImage(
                                                    'assets/images/cat.png')
                                                as ImageProvider<Object>,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      // Navigate to the page to register a new pet
                      await Navigator.pushNamed(context, '/pets');

                      // After returning, update the pet data
                      await petsDetailsProvider.loadPets();
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
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Consumer<OwnerDashboardProvider>(
              builder: (context, ownerDashboardProvider, child) {
                if (petsDetailsProvider.isDataLoaded &&
                    petsDetailsProvider.pets.isNotEmpty) {
                  final pet = petsDetailsProvider
                      .pets[ownerDashboardProvider.selectedPetIndex];

                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: pet['imagePath'] != null
                              ? FileImage(File(pet['imagePath']))
                              : AssetImage('assets/images/cat.png')
                                  as ImageProvider<Object>,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${pet['petName']}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                'Breed: ${pet['breed']}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                'Age: ${pet['age']}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            // Services Section
            Text(
              'Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/bell.gif',
                          width: 30, height: 30),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (_) => ReminderProvider(),
                              child: ReminderScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reminder',
                      style: TextStyle(
                        color: LightColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/home.gif',
                          width: 30, height: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, '/petSitters');
                      },
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pet Sitting',
                      style: TextStyle(
                        color: LightColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/sad.gif',
                          width: 30, height: 30),
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Lost your pet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: LightColors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/more.gif',
                          width: 30, height: 30),
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                    ),
                    SizedBox(height: 5),
                    Text(
                      'More',
                      style: TextStyle(
                        color: LightColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: CurvedPainter(),
          ),
          CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: Colors.transparent,
            buttonBackgroundColor: Colors.white,
            height: 60,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: Colors.black),
              Icon(Icons.favorite, size: 30, color: Colors.black),
              Icon(Icons.notifications, size: 30, color: Colors.black),
            ],
            onTap: (index) {
              // Handle navigation to different pages based on the index
              if (index == 0) {
                // Navigate to Home page
              } else if (index == 1) {
                // Navigate to Like/Favorites page
              } else if (index == 2) {
                // Navigate to Reminder page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => ReminderProvider(),
                      child: ReminderScreen(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..quadraticBezierTo(size.width * 0.5, -30, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
