import 'package:flutter/material.dart';

// Define the colors
const Color purple80 = Color(0xFFD0BCFF);
const Color purpleGrey80 = Color(0xFFCCC2DC);
const Color pink80 = Color(0xFFEFB8C8);

const Color purple40 = Color(0xFF6650a4);
const Color purpleGrey40 = Color(0xFF625b71);
const Color pink40 = Color(0xFF7D5260);

// Create the color schemes
const ColorScheme lightColorScheme = ColorScheme.light(
  primary: purple40,
  secondary: purpleGrey40,
  tertiary: pink40,
  surface: Color(0xFFFFFBFE),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onTertiary: Colors.white,
  onSurface: Color(0xFF1C1B1F),
);

const ColorScheme darkColorScheme = ColorScheme.dark(
  primary: purple80,
  secondary: purpleGrey80,
  tertiary: pink80,
  surface: Color(0xFF121212),
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onTertiary: Colors.black,
  onSurface: Colors.white,
);

// Create the ThemeData objects
ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  primaryColor: lightColorScheme.primary,
  canvasColor: lightColorScheme.surface,
  scaffoldBackgroundColor: lightColorScheme.surface,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightColorScheme.onSurface),
    bodyMedium: TextStyle(color: lightColorScheme.onSurface),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  primaryColor: darkColorScheme.primary,
  canvasColor: darkColorScheme.surface,
  scaffoldBackgroundColor: darkColorScheme.surface,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: darkColorScheme.onSurface),
    bodyMedium: TextStyle(color: darkColorScheme.onSurface),
  ),
);