import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'MyHomePage.dart';
import 'configForDebugWindows.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  // windowManager
  WindowOptions? windowOptions = configForDebug();
  if (windowOptions != null){
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:Colors.grey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

