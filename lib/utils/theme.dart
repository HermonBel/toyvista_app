import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Inter',
    primarySwatch: Colors.blue,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: toyBlue,
      primary: toyBlue,
      secondary: toyYellow,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold),
      displayMedium:
          TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
  );
}
