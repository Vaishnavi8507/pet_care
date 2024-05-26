import 'package:flutter/material.dart';

import '../pages/owner&pet/owner_signup.dart';

class RegisterProvider with ChangeNotifier {
  void navigateToOwner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OwnerReg()),
    );
  }

  void navigateToVolunteer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OwnerReg()),
    );
  }
}
