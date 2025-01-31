import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'Pages/AuthorisationPages/signIn.dart';
import 'Pages/navBarPages/navBar.dart';
import 'Utils/Theme/themeConstant.dart';
import 'Utils/Theme/themeManager.dart';
import 'Utils/configForDebugWindows.dart';


void main() async {
  runApp(MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // useMaterial3:true,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      // darkTheme: ThemeData.dark(),
      //home: const NavBarClass(),
      home:SignIn(),
    );
  }
}
