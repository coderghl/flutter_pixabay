import 'package:flutter/cupertino.dart';
import 'package:flutter_pixabay/theme/app_theme.dart';

class Global {
  static AppTheme appTheme = AppTheme();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    appTheme.initTheme();
  }
}
