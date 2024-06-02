import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/light_colors.dart';
import '../../provider/pet_reg_provider.dart';
import '../../widgets/components/text_button.dart';
import '../../widgets/components/textfield.dart';

class PetRegistration extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.primaryDarkColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Text(
                'Register Your Pet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: LightColors.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Consumer<PetRegistrationProvider>(
                    builder: (context, provider, child) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: LightColors.backgroundColor,
                                  backgroundImage: provider.image != null
                                      ? FileImage(File(provider.image!.path))
                                      : null,
                                  child: provider.image == null
                                      ? Icon(
                                          Icons.pets,
                                          color: LightColors.textColor,
                                          size: 60,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: LightColors.textColor,
                                    ),
                                    onPressed: () {
                                      provider.pickImage();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            MyTextField(
                              hintText: 'Pet Name',
                              obsText: false,
                              controller: _nameController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              textStyle:
                                  TextStyle(color: LightColors.textColor),
                              fillColor: LightColors.backgroundColor,
                            ),
                            MyTextField(
                              hintText: 'Breed',
                              obsText: false,
                              controller: _breedController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              textStyle:
                                  TextStyle(color: LightColors.textColor),
                              fillColor: LightColors.backgroundColor,
                            ),
                            MyTextField(
                              hintText: 'Age',
                              obsText: false,
                              controller: _ageController,
                              //keyboardType: TextInputType.number,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                              prefixIcon: null,
                            ),
                            MyTextField(
                              hintText: 'Weight',
                              obsText: false,
                              controller: _ageController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                              prefixIcon: null,
                            ),
                            MyTextField(
                              hintText: 'Gender',
                              obsText: false,
                              controller: _ageController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                              prefixIcon: null,
                            ),
                            SizedBox(height: 5),
                            CustomTextButton(
                              onPressed: () {
                                provider.setPetName(_nameController.text);
                                provider.setBreed(_breedController.text);
                                provider.setAge(_ageController.text);
                                provider.registerPet();
                              },
                              text: 'Register',
                              backgroundColor: LightColors.primaryDarkColor,
                              textColor: LightColors.textColor,
                              fontSize: 15,
                              width: 100,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
