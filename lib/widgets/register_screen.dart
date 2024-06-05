import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/theme/light_colors.dart';
import '../provider/register_provider.dart';
import 'components/text_button.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int animationCount = 0;

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
        backgroundColor: LightColors.primaryDarkColor,
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      'Hello !',
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
                      'Good Hoomans ',
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
                        ScaleTransition(
                          scale: _animation,
                          child: CircleAvatar(
                            radius: 150,
                            backgroundColor: LightColors.primaryDarkColor,
                            backgroundImage:
                                AssetImage('assets/images/petty.jpeg'),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          textAlign: TextAlign.center,
                          '"Until one has loved an animal, a part of ones soul remains unawakened"',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          textAlign: TextAlign.center,
                          "Continue as",
                          style: TextStyle(
                            color: LightColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: 20), // Add space between text and buttons
                        // Elevated buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Consumer<RegisterProvider>(
                              builder: (context, provider, child) {
                                return CustomTextButton(
                                  text: 'Owner',
                                  
                                  onPressed: () {
                                    provider.navigateToOwner(context);
                                  },
                                  backgroundColor: LightColors.backgroundColor,
                                  textColor: LightColors.textColor,
                                  fontSize: 15,
                                  width: 160,
                                  textStyle: TextStyle(
                                    fontSize: 28, // Customize the font size
                                    fontWeight: FontWeight.bold, // Customize the font weight
                                    letterSpacing: 1.2, // Customize the letter spacing
                                     // Customize the font style
                                  ),
                                );
                              },
                            ),
                            Consumer<RegisterProvider>(
                                builder: (context, provider, child) {
                              return CustomTextButton(
                                text: 'Volunteer',
                                onPressed: () {
                                  provider.navigateToVolunteer(context);
                                },
                                backgroundColor: LightColors.buttonColor,
                                textColor: LightColors.textColor,
                                fontSize: 15,
                                width: 160,
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 22,
              right: 25,
              child: GestureDetector(
                onTap: () {
                  final provider =
                      Provider.of<RegisterProvider>(context, listen: false);
                  provider.navigateToPets(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}