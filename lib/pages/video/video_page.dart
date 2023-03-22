import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_type_entity.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/pages/search/search_page.dart';
import 'package:flutter_pixabay/pages/video/widget/video_tab_page_widget.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  VideoOrderEnum dataSortType = VideoOrderEnum.popular;

  int _currentIndex = 0;

  List<GlobalKey<VideoTabPageWidgetState>> keys = [
    GlobalKey(debugLabel: "allVideo"),
    GlobalKey(debugLabel: "film"),
    GlobalKey(debugLabel: "animation"),
  ];

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: _currentIndex,
      length: videoTypeList.length,
      vsync: this,
    );
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            title: const Text("Pixabay"),
            bottom: _buildTabBar(),
            actions: [
              _buildSearchBtn(),
              _buildPopupMenu(),
            ],
          ),
        ];
      },
      body: _buildTabBarView(),
    );
  }

  TabBar _buildTabBar() => TabBar(
      controller: _tabController,
      onTap: _handelTabOnTap,
      tabs: videoTypeList
          .map((item) => Tab(text: item.name, icon: Icon(item.iconData)))
          .toList());

  Widget _buildTabBarView() {
    return PageView.builder(
      onPageChanged: _handelPageChange,
      itemCount: videoTypeList.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return KeepAliveWidget(
          wantKeepAlive: true,
          child: VideoTabPageWidget(
            key: keys[index],
            type: videoTypeList[index],
          ),
        );
      },
    );
  }

  Widget _buildSearchBtn() => IconButton(
        onPressed: _handelGotoSearchPage,
        icon: const Icon(Icons.search_rounded),
      );

  Widget _buildPopupMenu() => PopupMenuButton(
        initialValue: dataSortType,
        onSelected: _handelSortType,
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem<VideoOrderEnum>(
              value: VideoOrderEnum.popular,
              child: ListTile(
                leading: Icon(Icons.recommend_rounded),
                title: Text("Popular"),
              ),
            ),
            PopupMenuItem<VideoOrderEnum>(
              value: VideoOrderEnum.latest,
              child: ListTile(
                leading: Icon(Icons.fiber_new_rounded),
                title: Text("Latest"),
              ),
            ),
          ];
        },
      );

  void _handelSortType(VideoOrderEnum value) {
    dataSortType = value;
    keys[_currentIndex].currentState?.getVideo(dataSortType);
    setState(() {});
  }

  void _handelGotoSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
      ),
    );
  }

  void _handelTabOnTap(int index) {
    _currentIndex = index;
    _pageController.animateToPage(
      _currentIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  void _handelPageChange(int index) {
    _currentIndex = index;
    _tabController.animateTo(
      _currentIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }
}