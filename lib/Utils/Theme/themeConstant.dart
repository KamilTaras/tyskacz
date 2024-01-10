import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.transparent, // Set the background color for Scaffold widgets
    canvasColor: mainGreen,
    switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(mainGreen),
        trackOutlineColor: MaterialStateProperty.all<Color>(mainBackgroundColor)),
    brightness: Brightness.light,
    primaryColor: mainGreen,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
        ),
    ),
    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(backgroundColor: mainGreen),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
            // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            //     EdgeInsets.symmetric(horizontal: 70.0, vertical: 70.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(mainGreen))),
    textTheme: TextTheme(
        displayLarge:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily:'MainFont', fontSize: 20.0,)),
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
