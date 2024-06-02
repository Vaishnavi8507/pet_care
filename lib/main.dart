import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/constants/theme/theme_provider.dart';
import 'package:pet_care/firebase_options.dart';
import 'package:pet_care/pages/owner&pet/owner_login.dart';
import 'package:pet_care/pages/owner&pet/owner_signup.dart';
import 'package:pet_care/pages/owner&pet/pet_register.dart';
import 'package:pet_care/pages/pets_page/pets.dart';
import 'package:pet_care/pages/volunteer/volunteer_login_page.dart';
import 'package:pet_care/pages/volunteer/volunteer_reg.dart';
import 'package:pet_care/provider/owner_login_provider.dart';
import 'package:pet_care/provider/owner_reg_provider.dart';
import 'package:pet_care/provider/pet_reg_provider.dart';
import 'package:pet_care/provider/pets_provider.dart';
import 'package:pet_care/provider/register_provider.dart';
import 'package:pet_care/provider/volunteer_login_provider.dart';
import 'package:pet_care/provider/volunteer_reg_provider.dart';
import 'package:pet_care/widgets/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OwnerRegProvider()),
        ChangeNotifierProvider(create: (context) => OwnerLoginProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => PetsProvider()),
        ChangeNotifierProvider(create: (context) => PetRegistrationProvider()),
        ChangeNotifierProvider(create: (context) => VolunteerRegProvider()),
        ChangeNotifierProvider(create: (context) => VolunteerLoginProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/ownerReg': (context) => OwnerReg(),
        '/ownerLogin': (context) => OwnerLogin(),
        '/pets': (context) => Pets(),
        '/petRegister': (context) => PetRegistration(),
        '/volunteerRegister': (context) => VolunteerReg(),
        '/volunteerLogin': (context) => VolunteerLogin(),
      },
    );
  }
}
