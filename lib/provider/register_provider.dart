import 'package:flutter/material.dart';
import 'package:pet_care/pages/owner&pet/owner_login.dart';
import 'package:pet_care/pages/owner&pet/owner_signup.dart';
import 'package:pet_care/pages/volunteer/volunteer_login_page.dart';
import 'package:pet_care/pages/volunteer/volunteer_reg.dart';

import '../constants/theme/light_colors.dart';
import '../pages/pets_page/pets.dart';

class RegisterProvider with ChangeNotifier {
  void navigateToOwner(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Owner',
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: LightColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OwnerReg()),
                  );
                },
              ),
              GestureDetector(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: LightColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OwnerLogin()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToVolunteer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Volunteer', textAlign: TextAlign.center),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: LightColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VolunteerReg()),
                  );
                },
              ),
              GestureDetector(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: LightColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VolunteerLogin()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToPets(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Pets()));
  }

  void navigateToPetRegistration(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Pets()));
  }
}
