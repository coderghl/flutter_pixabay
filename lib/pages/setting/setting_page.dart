import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/theme/select_theme_page.dart';
import 'package:flutter_pixabay/widgets/list_tile_m3_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ListTileM3Widget(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectThemePage(),
              ),
            ),
            leading: const Icon(Icons.color_lens_rounded),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            title: const Text("Theme Selection"),
          )
        ],
      ),
    );
  }
}
