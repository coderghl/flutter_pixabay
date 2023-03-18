import 'package:flutter/material.dart';
import 'package:flutter_pixabay/global.dart';
import 'package:flutter_pixabay/pages/page_container/page_container.dart';
import 'package:flutter_pixabay/utils/theme/app_theme_state.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then(
      (value) => runApp(
        ChangeNotifierProvider<AppThemeState>.value(
          value: Global.appTheme,
          child: Consumer<AppThemeState>(
            builder: (context, value, child) => MyApp(),
          ),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: Global.appTheme.themeMode,
      theme: Global.appTheme.lightTheme,
      darkTheme: Global.appTheme.darkTheme,
      home: const PageContainer(),
    );
  }
}
