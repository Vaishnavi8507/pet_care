import 'package:flutter/material.dart';
import 'package:pet_care/provider/get_ownerData_provider.dart';
import 'package:pet_care/provider/owner_editprofile_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/light_colors.dart';

class OwnerEditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: LightColors.textColor,
          fontSize: 25,
        ),
        title: Text('Edit Profile', textAlign: TextAlign.center),
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
                              backgroundImage:
                                  getImageProvider(ownerDetailsProvider),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () =>
                                    ownerDetailsProvider.pickProfileImage(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Name:',
                        style: TextStyle(
                            color: LightColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ownerDetailsProvider.name,
                        style: TextStyle(
                            color: LightColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email:',
                        style: TextStyle(
                            color: LightColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ownerDetailsProvider.email,
                        style: TextStyle(
                            fontSize: 16,
                            color: LightColors.textColor,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                              color: LightColors.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onChanged: (value) =>
                            Provider.of<OwnerEditProfileProvider>(context,
                                    listen: false)
                                .setPhoneNo(value),
                        controller: TextEditingController(
                            text: ownerDetailsProvider.phoneNo),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                ownerDetailsProvider.saveProfile(context),
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LightColors.primaryColor,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                ownerDetailsProvider.ownerLogout(context),
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
                    child:
                        CircularProgressIndicator(), // Show loading indicator until data is loaded
                  );
          },
        ),
      ),
    );
  }
}

  ImageProvider getImageProvider(OwnerDetailsGetterProvider ownerDetailsProvider) {
    if (ownerDetailsProvider.profileImageUrl != null) {
      return NetworkImage(ownerDetailsProvider.profileImageUrl!);
    } else {
      // Check if file image is available, if not, return default image
      if (ownerDetailsProvider.profileImageFile != null) {
        return FileImage(ownerDetailsProvider.profileImageFile!);
      } else {
        return AssetImage('assets/images/default.png');
      }
    }
  }




