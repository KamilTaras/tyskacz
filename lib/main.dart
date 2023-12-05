import 'package:flutter/material.dart';
import 'package:tyskacz/constatntValues.dart';
import 'package:window_manager/window_manager.dart';
import 'Pages/navBar.dart';
import 'colors.dart';
import 'configForDebugWindows.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: maingreen
      ),
      darkTheme: ThemeData.dark(),
      home: NavBarClass(),
    );
  }
}
