import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
    ),
    listTileTheme: ListTileThemeData(
        tileColor: Colors.white, // Background color of the ListTile
        iconColor: Colors.grey, // Color of the leading/trailing icons
        textColor: Colors.grey, // Color for the text
        selectedColor: Colors.grey[300], // Color when the ListTile is selected
        selectedTileColor: Colors.grey[200], // Background color when selected
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding inside the ListTile
        shape: RoundedRectangleBorder( // Shape of the ListTile
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey[300]!), // Border color
        ),
    ),
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
            // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            //     EdgeInsets.symmetric(horizontal: 70.0, vertical: 70.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(mainGreen))),
    textTheme: TextTheme(
        displayLarge:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
