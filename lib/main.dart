import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/constants/theme/theme_provider.dart';
import 'package:pet_care/controller/volunteer_registration_provider.dart';
import 'package:pet_care/firebase_options.dart';
import 'package:pet_care/pages/volunteer/volunteer_login_page.dart';
import 'package:pet_care/pages/volunteer_signup.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => VolunteerRegProvider()), 
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VolunteerReg(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}