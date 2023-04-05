import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/app_about/app_about_page.dart';
import 'package:flutter_pixabay/pages/privacy/privacy_page.dart';
import 'package:flutter_pixabay/pages/theme/app_theme_page.dart';
import 'package:flutter_pixabay/widgets/list_tile_m3_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text("Setting"),
            centerTitle: false,
          ),
        ];
      },
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            ListTileM3Widget(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AppThemePage(),
                ),
              ),
              leading: const Icon(Icons.color_lens_outlined),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
              title: const Text("App Theme"),
            ),
            ListTileM3Widget(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AppAboutPage(),
                ),
              ),
              leading: const Icon(Icons.info_outline),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
              title: const Text("About"),
            ),
            ListTileM3Widget(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const PrivacyPage(),
                ),
              ),
              leading: const Icon(Icons.privacy_tip_outlined),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
              title: const Text("Privacy"),
            ),
          ],
        ),
      ),
    );
  }
}
