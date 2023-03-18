import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/theme/app_theme_page.dart';
import 'package:flutter_pixabay/widgets/list_tile_m3_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 44),
      child: Column(
        children: [
          ListTileM3Widget(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppThemePage(),
              ),
            ),
            leading: const Icon(Icons.color_lens_rounded),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            title: const Text("App Theme"),
          ),
        ],
      ),
    );
  }
}
