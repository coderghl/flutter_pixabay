import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/setting/setting_page.dart';
import 'package:flutter_pixabay/pages/category/category_page.dart';
import 'package:flutter_pixabay/pages/image/image_page.dart';
import 'package:flutter_pixabay/pages/video/video_page.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({super.key});

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  int _currentIndex = 0;

  final _pages = const [
    ImagePage(),
    VideoPage(),
    CategoryPage(),
    SettingPage(),
  ];

  // 切换页面
  void switchPage(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: switchPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.image_rounded),
            label: "Image",
          ),
          NavigationDestination(
            icon: Icon(Icons.videocam_rounded),
            label: "Video",
          ),
          NavigationDestination(
            icon: Icon(Icons.category_rounded),
            label: "Category",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: "Setting",
          )
        ],
      ),
    );
  }
}
