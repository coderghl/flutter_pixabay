import 'package:flutter/cupertino.dart';
import 'package:flutter_pixabay/theme/app_theme_state.dart';

class Global {
  static AppThemeState appTheme = AppThemeState();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    appTheme.initTheme();
  }
}
