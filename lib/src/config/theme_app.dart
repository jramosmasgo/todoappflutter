import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFEEEFF5),
    cardColor: Colors.white,
    secondaryHeaderColor: Colors.white,
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Colors.white),
    useMaterial3: true,
    primaryColor: const Color(0xFF5F33E1));

// Color(0xFFEEEFF5)

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    // scaffoldBackgroundColor: Colors.black,
    secondaryHeaderColor: const Color(0xFF17153B),
    primaryColor: const Color(0xFF2E236C));


// ThemeData darkTheme = ThemeData(
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//     bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
//   ),
//   appBarTheme: const AppBarTheme(
//     color: Colors.red,
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: Colors.red,
//     brightness: Brightness.dark,
//   ),
// );
