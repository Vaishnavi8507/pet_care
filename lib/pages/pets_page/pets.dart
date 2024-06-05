import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/light_colors.dart';
import '../../provider/pets_provider.dart';
import '../owner&pet/pet_register.dart';

class Pets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.primaryDarkColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                'What kind of pet do you have?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black54,
                    onPressed: () {
                      Provider.of<PetsProvider>(context, listen: false)
                          .previousImage();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Consumer<PetsProvider>(
                        builder: (context, imageScrollProvider, child) {
                          return Image.asset(
                            imageScrollProvider.currentImage,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.black54,
                    onPressed: () {
                      Provider.of<PetsProvider>(context, listen: false)
                          .nextImage();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Text(
              '"It takes nothing away from a human to be kind to an animal"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: LightColors.textColor,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Provider.of<PetsProvider>(context, listen: false)
                    .navigateToPetRegistration(context);
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black54, // Text color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _navigateToPetRegistration(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PetRegistration(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}