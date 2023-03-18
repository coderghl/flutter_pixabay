import 'package:flutter/material.dart';
import 'package:flutter_pixabay/utils/constants.dart';
import 'package:flutter_pixabay/utils/shared_preferences/shared_preferences_util.dart';

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

  Future<void> initTheme() async {
    selColorSchemeSeed = SharedPreferencesUtil().getInt(kCurrentColor);

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

  void toggleThemeSeedColor(int index) {
    SharedPreferencesUtil().setInt(kCurrentColor, index);
    initTheme();
    notifyListeners();
  }

  /// 切换主题模式
  void toggleThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }
}
