import 'package:flutter/material.dart';
import 'package:pet_care/controller/volunteer_registration_provider.dart';
import 'package:pet_care/widgets/components/textfield.dart';
import 'package:provider/provider.dart';
 
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
      backgroundColor: Theme.of(context).backgroundColor,  
      body: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40), 
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,  
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                            ),
                            MyTextField(
                              hintText: 'Email',
                              obsText: false,
                              controller: _emailController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                            ),
                            MyTextField(
                              hintText: 'Password',
                              obsText: !provider.isPasswordVisible,
                              controller: _passwordController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                              focusNode: FocusNode(),
                            ),
                            MyTextField(
                              hintText: 'Phone No',
                              obsText: false,
                              controller: _phoneNoController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                            ),
                            MyTextField(
                              hintText: 'Age',
                              obsText: false,
                              controller: _ageController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                            ),
                            MyTextField(
                              hintText: 'Occupation (Optional)',
                              obsText: false,
                              controller: _occupationController,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.zero,
                            ),
                            CheckboxListTile(
                              title: Text("Have you owned a pet before?"),
                              value: provider.ownedPet,
                              onChanged: (value) => provider.toggleOwnedPet(value ?? false),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                provider.setName(_nameController.text);
                                provider.setEmail(_emailController.text);
                                provider.setPassword(_passwordController.text);
                                provider.setPhoneNo(_phoneNoController.text);
                                provider.setAge(_ageController.text);
                                provider.setOccupation(_occupationController.text);
                                provider.signUp();
                              },
                              child: Text('Sign Up'),
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
