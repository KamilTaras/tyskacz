import 'package:flutter/material.dart';
import 'package:tyskacz/Utils/constantValues.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: mainBackgroundColor, // Set the background color for Scaffold widgets
    canvasColor: mainGreen,
    switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(mainGreen),
        trackOutlineColor: MaterialStateProperty.all<Color>(mainBackgroundColor)),
    brightness: Brightness.light,
    primaryColor: mainGreen,
    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(backgroundColor: mainGreen),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(mainGreen))),
    textTheme: TextTheme(
        displayLarge:
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
