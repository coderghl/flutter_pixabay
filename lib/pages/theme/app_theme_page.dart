import 'package:flutter/material.dart';
import 'package:flutter_pixabay/global.dart';
import 'package:flutter_pixabay/pages/theme/widgets/select_theme_seed_color_widget.dart';
import 'package:flutter_pixabay/widgets/list_tile_m3_widget.dart';

class AppThemePage extends StatefulWidget {
  const AppThemePage({super.key});

  @override
  State<AppThemePage> createState() => _AppThemePageState();
}

class _AppThemePageState extends State<AppThemePage> {
  late Brightness brightness;

  @override
  Widget build(BuildContext context) {
    var mode = Global.appTheme.themeMode;
    if (mode == ThemeMode.system) {
      brightness = MediaQuery.of(context).platformBrightness;
    } else {
      brightness = mode == ThemeMode.light ? Brightness.light : Brightness.dark;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Toggle Theme Mode",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListTileM3Widget(
              title: Text(brightness == Brightness.light ? "Light" : "Dark"),
              margin: const EdgeInsets.only(bottom: 26),
              leading: brightness == Brightness.light
                  ? Icon(Icons.wb_sunny_rounded)
                  : Icon(Icons.dark_mode_rounded),
              trailing: Switch(
                value: brightness == Brightness.light,
                onChanged: (bool value) {
                  if (value) {
                    brightness = Brightness.light;
                    Global.appTheme.toggleThemeMode(ThemeMode.light);
                  } else {
                    brightness = Brightness.dark;
                    Global.appTheme.toggleThemeMode(ThemeMode.dark);
                  }
                  setState(() {});
                },
              ),
            ),
            const SelectThemeSeedColorWidget(),
          ],
        ),
      ),
    );
  }
}
