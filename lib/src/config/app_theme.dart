import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  //Colors for theme
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color? lightAccent = Colors.blueGrey[900];
  static Color darkAccent = Colors.white;
  static Color lightBG = const Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color badgeColor = Colors.red;
  static Color? greyColor = Colors.grey[500];
  static Color? blueGrey = Colors.blueGrey[300];
  static MaterialColor appColor = Colors.orange;

  static ThemeData lightTheme = ThemeData(
      backgroundColor: lightBG,
      scaffoldBackgroundColor: lightBG,
      appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarTextStyle: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: appColor)
          .copyWith(secondary: lightAccent, brightness: Brightness.light),
      textSelectionTheme: TextSelectionThemeData(cursorColor: lightAccent),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: appColor),
        errorStyle: const TextStyle(color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: greyColor!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: appColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: darkBG,
          contentTextStyle: TextStyle(color: darkAccent)));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      backgroundColor: darkBG,
      scaffoldBackgroundColor: darkBG,
      appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarTextStyle: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: appColor)
          .copyWith(secondary: darkAccent, brightness: Brightness.dark),
      textSelectionTheme: TextSelectionThemeData(cursorColor: darkAccent),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: appColor),
        errorStyle: const TextStyle(color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: greyColor!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: appColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: lightBG,
          contentTextStyle: TextStyle(color: lightAccent)));
}
