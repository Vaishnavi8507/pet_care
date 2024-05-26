import 'package:flutter/material.dart';
import 'package:pet_care/constants/theme/dark_colors.dart';
import 'package:pet_care/constants/theme/light_colors.dart';

// Light Theme Configuration
final ThemeData lightMode = ThemeData(
  // Primary colors
  primaryColor: LightColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: LightColors.accentColor,
  ),

  // Background colors
  backgroundColor: LightColors.backgroundColor,
  scaffoldBackgroundColor: LightColors.scaffoldBackgroundColor,

  // Error color
  errorColor: LightColors.errorColor,

  // Text theme
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: LightColors.textColor),
    bodyText2: TextStyle(color: LightColors.textColorLight),
  ),

  // Elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: LightColors.buttonTextColor,
      backgroundColor: LightColors.buttonColor,
    ),
  ),

  // Outlined button theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: LightColors.buttonColor,
    ),
  ),
);




// Dark Theme Configuration
final ThemeData darkMode = ThemeData(
  // Primary colors
  primaryColor: DarkColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: DarkColors.accentColor,
  ).copyWith(
    background: DarkColors.backgroundColor,
    error: DarkColors.errorColor,
  ),

  // Background colors
  scaffoldBackgroundColor: DarkColors.scaffoldBackgroundColor,

  // Text theme
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: DarkColors.textColor),
    bodyText2: TextStyle(color: DarkColors.textColorLight),
  ),

  // Elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: DarkColors.buttonTextColor,
      backgroundColor: DarkColors.buttonColor,
    ),
  ),

  // Outlined button theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: DarkColors.buttonColor,
    ),
  ),
);
