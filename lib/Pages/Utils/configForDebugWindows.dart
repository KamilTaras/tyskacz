import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Size defaultSize = Size(390, 844);

WindowOptions? configForDebug() {
  WindowOptions? windowOptions;
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    windowOptions = WindowOptions(
        alwaysOnTop: true,
        minimumSize: defaultSize,
        maximumSize: defaultSize,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        center: false);
  }
  windowManager.setAlignment(Alignment.topRight);

  return windowOptions;
}
