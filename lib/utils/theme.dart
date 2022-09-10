
import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/constants/constants.dart';

class CustomAppTheme{

  // I don't want to create instance for this class,
  // so I make its constructor private
  // here we will define our theme
  CustomAppTheme._();

  // There are a lot of options that you can handle in this
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: lightThemeSwatch, // import from constant class
    primaryColor: lightPrimaryColor,// import from constant class
    textTheme: const TextTheme(
      headline2: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 30,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        color: Colors.black
      ),
      // you can define different text styles , colors , font size and more
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: darkThemeSwatch,
    primaryColor: darkPrimaryColor,
    textTheme: const TextTheme(
      headline2: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 30,
        color: Colors.yellowAccent
      ),
      subtitle1: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        color: Colors.yellowAccent
      ),
    ),
  );
}