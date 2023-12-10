import 'package:flutter/material.dart';
import 'package:tyskacz/Pages/atttractionDescription.dart';
import 'package:tyskacz/Utils/constantValues.dart';
import 'package:window_manager/window_manager.dart';
import 'Pages/navBar.dart';
import 'Utils/Theme/colors.dart';
import 'Utils/Theme/themeConstant.dart';
import 'Utils/Theme/themeManager.dart';
import 'Utils/configForDebugWindows.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  // windowManager
  WindowOptions? windowOptions = configForDebug();
  if (windowOptions != null) {
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();

      await windowManager.focus();
    });
  }
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
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      // darkTheme: ThemeData.dark(),
      home: NavBarClass(),
    );
  }
}
