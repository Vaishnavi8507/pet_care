import 'package:flutter/material.dart';
import 'package:pet_care/widgets/register_screen.dart';
import 'package:provider/provider.dart';

import '../constants/theme/dark_colors.dart';
import '../provider/splash_screen_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashScreenProvider _splashScreenProvider;

  @override
  void initState() {
    super.initState();
    _splashScreenProvider = SplashScreenProvider(this);
    _splashScreenProvider.addListener(() {
      // Navigate to the register screen when the provider notifies
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Register()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashScreenProvider>(
      create: (_) => _splashScreenProvider,
      child: Scaffold(
        backgroundColor: DarkColors.backgroundColor,
        body: Center(
          child: Consumer<SplashScreenProvider>(
            builder: (context, provider, child) {
              return FadeTransition(
                opacity: provider.animation,
                child: Image.asset(
                  'assets/images/icon_heart.png',
                  width: 900,
                  height: 900,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _splashScreenProvider.dispose();
    super.dispose();
  }
}
