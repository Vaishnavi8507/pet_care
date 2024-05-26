import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/theme/dark_colors.dart';
import '../provider/register_provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int animationCount = 0;

  // Define button constants
  static const Color buttonColor =
      Colors.white70; // Define your desired button color
  // static const double buttonSize = 120.0; // Define your desired button size

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 1.5),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.5, end: 1),
        weight: 1,
      ),
    ]).animate(_animationController)
      ..addListener(() {
        if (_animationController.status == AnimationStatus.completed) {
          animationCount++;
          if (animationCount >= 2) {
            _animationController.stop();
          }
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterProvider>(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        backgroundColor: DarkColors.primaryDarkColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to the world of',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 8), // Add some space between lines
              Center(
                child: Text(
                  'Pets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 40), // Add space between text and image
              Center(
                child: Column(
                  children: [
                    // Add animation to the image
                    ScaleTransition(
                      scale: _animation,
                      child: CircleAvatar(
                        radius: 150,
                        backgroundImage: AssetImage('assets/images/petty.jpeg'),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      textAlign: TextAlign.center,
                      '"Until one has loved an animal, a part of ones soul remains unawakened"',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 60), // Add space between image and buttons
                    // Add text
                    Text(
                      'Continue as',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20), // Add space between text and buttons
                    // Elevated buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<RegisterProvider>(
                          builder: (context, provider, child) {
                            return ElevatedButton(
                              onPressed: () {
                                provider.navigateToOwner(context);
                              },
                              child: Text(
                                'Owner',
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.normal,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(110, 50),
                                backgroundColor: buttonColor,
                              ),
                            );
                          },
                        ),
                        Consumer<RegisterProvider>(
                          builder: (context, provider, child) {
                            return ElevatedButton(
                              onPressed: () {
                                provider.navigateToVolunteer(context);
                              },
                              child: Text(
                                'Volunteer',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(110, 50),
                                backgroundColor: buttonColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
