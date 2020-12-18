import 'package:flutter/material.dart';

class ColorTheme {

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.cyan[400],
      cardColor: Colors.blueGrey.shade800,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 36.0,
        ),
      ),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        subtitle2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.grey.shade400,
      cardColor: Colors.grey.shade100,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.pink,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(
          size: 36.0,
        ),
      ),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        headline2: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        subtitle2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
