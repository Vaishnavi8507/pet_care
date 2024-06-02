import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/light_colors.dart';
import '../../provider/forgot_password_provider.dart';
import 'components/text_button.dart';
import 'components/textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.primaryDarkColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Text(
              'Forgot Password',
              style: TextStyle(
                color: LightColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Consumer<ForgotPasswordProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    MyTextField(
                      hintText: 'Enter your email',
                      obsText: false,
                      controller: _emailController,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.zero,
                      prefixIcon: Icon(Icons.email_outlined),
                      textStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                    ),
                    if (provider.isLoading)
                      CircularProgressIndicator()
                    else
                      CustomTextButton(
                        onPressed: () {
                          provider.setEmail(_emailController.text);
                          provider.resetPassword();
                        },
                        text: 'Reset Password',
                        backgroundColor: LightColors.primaryDarkColor,
                        textColor: LightColors.textColor,
                        fontSize: 15,
                        width: 200,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
