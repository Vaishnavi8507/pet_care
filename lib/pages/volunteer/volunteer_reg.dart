import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/widgets/components/text_button.dart';
import 'package:pet_care/widgets/components/textfield.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/light_colors.dart';
import '../../provider/volunteer_reg_provider.dart';
//import '../../provider/volunteer_reg_provider.dart';

class VolunteerReg extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _ageController = TextEditingController();
  final _occupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.primaryDarkColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 2),
            Image.asset(
              'assets/images/landing-2.jpg',
              height: 100,
              width: 90,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: LightColors.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Consumer<VolunteerRegProvider>(
                    builder: (context, provider, child) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyTextField(
                              hintText: 'Name',
                              obsText: false,
                              controller: _nameController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.person),
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                            ),
                            MyTextField(
                              hintText: 'Email',
                              obsText: false,
                              controller: _emailController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.email_outlined),
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                            ),
                            MyTextField(
                              hintText: 'Password',
                              obsText: !provider.isPasswordVisible,
                              controller: _passwordController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              focusNode: FocusNode(),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  provider.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  provider.togglePasswordVisibility();
                                },
                              ),
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                            ),
                            MyTextField(
                              hintText: 'Phone No',
                              obsText: false,
                              controller: _phoneNoController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.phone),
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                            ),
                            MyTextField(
                              hintText: 'Age',
                              obsText: false,
                              controller: _ageController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.calendar_today),
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                            ),
                            MyTextField(
                              hintText: 'Occupation (Optional)',
                              obsText: false,
                              controller: _occupationController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.work_outline),
                              textStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                            ),
                            SizedBox(height: 5),
                            CustomTextButton(
                              onPressed: () {
                                provider.setName(_nameController.text);
                                provider.setEmail(_emailController.text);
                                provider.setPassword(_passwordController.text);
                                provider.setPhoneNo(_phoneNoController.text);
                                provider.setAge(_ageController.text);
                                provider
                                    .setOccupation(_occupationController.text);
                                provider.signUp();
                              },
                              text: 'Sign Up',
                              backgroundColor: LightColors.primaryDarkColor,
                              textColor: LightColors.textColor,
                              fontSize: 15,
                              width: 100,
                            ),
                            SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                  text: 'Already have an account?',
                                  style: TextStyle(
                                    color: LightColors.textColor,
                                    fontSize: 16,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' ',
                                    ),
                                    TextSpan(
                                        text: 'Sign In',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            provider.navigateToVolunteerLogin(
                                                context);
                                          })
                                  ]),
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