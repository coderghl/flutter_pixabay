import 'package:flutter/cupertino.dart';
import 'package:flutter_pixabay/utils/network/http/http.dart';
import 'package:flutter_pixabay/utils/shared_preferences/shared_preferences_util.dart';

import 'utils/theme/app_theme_state.dart';

class Global {
  static AppThemeState appTheme = AppThemeState();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    Http();
    await SharedPreferencesUtil.init();

    await appTheme.initTheme();
  }
}
