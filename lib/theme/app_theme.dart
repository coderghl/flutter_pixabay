import 'package:flutter/material.dart';

class AppTheme {
  int selColorSchemeSeed = 0;

  List<Color> colorSchemeSeedList = [
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.deepOrange,
    Colors.pink,
  ];

  late ThemeData lightTheme;

  late ThemeData darkTheme;

  void initTheme() {
    lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: colorSchemeSeedList[selColorSchemeSeed],
    );

    darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.green,
    );
  }
}
