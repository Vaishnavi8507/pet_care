import 'package:flutter/material.dart';
import 'package:pet_care/provider/get_volunteer_details_provider.dart';
import 'package:provider/provider.dart';

class VolunteerDashboard extends StatelessWidget {
  const VolunteerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Consumer<VolunteerDetailsGetterProvider>(
                    builder: (context, volunteerProvider, child) {
                  return Text(
                    'Hello ${volunteerProvider.name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/volunteerEditProfile');
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person, color: Colors.white),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ]),
            ])));
  }
}
