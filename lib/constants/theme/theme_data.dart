import 'package:flutter/material.dart';
import 'package:pet_care/constants/theme/dark_colors.dart';
import 'package:pet_care/constants/theme/light_colors.dart';

// Light Theme Configuration
final ThemeData lightMode = ThemeData(
  // Primary colors
  primaryColor: LightColors.primaryColor,
  scaffoldBackgroundColor: LightColors.scaffoldBackgroundColor,

  // Error color
  cardColor: LightColors.errorColor,

  // Text theme
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: LightColors.textColor),
    bodyMedium: TextStyle(color: LightColors.textColorLight),
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
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: LightColors.accentColor,
      )
      .copyWith(background: LightColors.backgroundColor),
);

// Dark Theme Configuration
final ThemeData darkMode = ThemeData(
  // Primary colors
  primaryColor: DarkColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: DarkColors.accentColor,
      )
      .copyWith(
        background: DarkColors.backgroundColor,
        error: DarkColors.errorColor,
      ),

  // Background colors
  scaffoldBackgroundColor: DarkColors.scaffoldBackgroundColor,

  // Text theme
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: DarkColors.textColor),
    bodyMedium: TextStyle(color: DarkColors.textColorLight),
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
