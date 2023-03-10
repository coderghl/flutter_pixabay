import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeState with ChangeNotifier {
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

  ThemeMode themeMode = ThemeMode.system;

  /// 初始化主题
  void initTheme() {
    lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: colorSchemeSeedList[selColorSchemeSeed],
    );

    darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: colorSchemeSeedList[selColorSchemeSeed],
    );
  }

  /// 切换主题
  void toggleThemeSeedColor(int index) {
    selColorSchemeSeed = index;
    initTheme();
    notifyListeners();
  }

  /// 切换主题模式
  void toggleThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }
}
