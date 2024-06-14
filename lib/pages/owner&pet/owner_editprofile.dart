import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_care/provider/get_ownerData_provider.dart';
import 'package:pet_care/provider/owner_editprofile_provider.dart';
import 'package:provider/provider.dart';

class OwnerEditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<OwnerDetailsGetterProvider>(
          builder: (context, ownerDetailsProvider, child) {
            return ownerDetailsProvider.isDataLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: ownerDetailsProvider.profileImageUrl != null
                                  ? NetworkImage(ownerDetailsProvider.profileImageUrl!)
                                  : AssetImage('assets/default_profile.png') as ImageProvider<Object>,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Provider.of<OwnerEditProfileProvider>(context, listen: false).pickProfileImage(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Name:',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ownerDetailsProvider.name,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email:',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ownerDetailsProvider.email,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (value) => Provider.of<OwnerEditProfileProvider>(context, listen: false).setPhoneNo(value),
                        controller: TextEditingController(text: ownerDetailsProvider.phoneNo),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Provider.of<OwnerEditProfileProvider>(context, listen: false).saveProfile(context),
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Provider.of<OwnerEditProfileProvider>(context, listen: false).ownerLogout(context),
                            child: Text('Logout'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(), // Show loading indicator until data is loaded
                  );
          },
        ),
      ),
    );
  }
}
