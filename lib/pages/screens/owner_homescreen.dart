import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_care/provider/get_ownerData_provider.dart';
import 'package:pet_care/provider/get_petData_provider.dart';
import 'package:pet_care/provider/owner_dashboard_provider.dart';

class OwnerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final petsDetailsProvider = Provider.of<PetsDetailsGetterProvider>(context);
    final ownerDashboardProvider = Provider.of<OwnerDashboardProvider>(context);
    // final ownerDetailsProvider = Provider.of<OwnerDetailsGetterProvider>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hello Hooman',
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
                  child: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person, color: Colors.white),
                    backgroundColor: Colors.blue,
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
                    child: petsDetailsProvider.isDataLoaded
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: petsDetailsProvider.pets.length,
                            itemBuilder: (context, index) {
                              final pet = petsDetailsProvider.pets[index];
                              return GestureDetector(
                                onTap: () {
                                  ownerDashboardProvider.selectPetIndex(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: pet['imagePath'] != null
                                        ? FileImage(File(pet['imagePath']))
                                        : AssetImage(
                                                'assets/default_profile.png')
                                            as ImageProvider<Object>,
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: CircularProgressIndicator()), // Show CircularProgressIndicator if data is not loaded
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, '/pets');
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
            // Use Consumer to rebuild the card widget when data is loaded
            Consumer<PetsDetailsGetterProvider>(
              builder: (context, petsDetailsProvider, child) {
                if (petsDetailsProvider.isDataLoaded &&
                    petsDetailsProvider.pets.isNotEmpty) {
                  final pet = petsDetailsProvider
                      .pets[ownerDashboardProvider.selectedPetIndex];

                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: pet['imagePath'] != null
                              ? FileImage(File(pet['imagePath']))
                              : AssetImage('assets/images/default_profile.png')
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
                  return Center(
                      child: CircularProgressIndicator()); // Show CircularProgressIndicator while loading
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
