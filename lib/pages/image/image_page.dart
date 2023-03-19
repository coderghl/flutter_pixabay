import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/pages/image/widgets/image_tab_page_widget.dart';
import 'package:flutter_pixabay/pages/search/search_page.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  ImageOrderEnum dataSortType = ImageOrderEnum.foryou;

  int _currentIndex = 0;

  List<GlobalKey<ImageTabPageWidgetState>> keys = [
    GlobalKey(debugLabel: "all"),
    GlobalKey(debugLabel: "photo"),
    GlobalKey(debugLabel: "illustration"),
    GlobalKey(debugLabel: "vector"),
  ];

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: _currentIndex,
      length: imageTypeList.length,
      vsync: this,
    );
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      onlyOneScrollInBody: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
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

  Widget _buildTabBarView() {
    return PageView.builder(
      onPageChanged: _handelPageChange,
      itemCount: imageTypeList.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return KeepAliveWidget(
          wantKeepAlive: true,
          child: ImageTabPageWidget(
            key: keys[index],
            type: imageTypeList[index],
          ),
        );
      },
    );
  }

  TabBar _buildTabBar() => TabBar(
      controller: _tabController,
      onTap: _handelTabOnTap,
      tabs: imageTypeList
          .map((item) => Tab(text: item.name, icon: Icon(item.iconData)))
          .toList());

  Widget _buildSearchBtn() => Hero(
        tag: "searchIcon",
        child: IconButton(
          onPressed: _handelGotoSearchPage,
          icon: const Icon(Icons.search_rounded),
        ),
      );

  Widget _buildPopupMenu() => PopupMenuButton(
        initialValue: dataSortType,
        onSelected: _handelSortType,
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem<ImageOrderEnum>(
              value: ImageOrderEnum.foryou,
              child: ListTile(
                leading: Icon(Icons.recommend_rounded),
                title: Text("For you"),
              ),
            ),
            PopupMenuItem<ImageOrderEnum>(
              value: ImageOrderEnum.latest,
              child: ListTile(
                leading: Icon(Icons.fiber_new_rounded),
                title: Text("Latest"),
              ),
            ),
            PopupMenuItem<ImageOrderEnum>(
              value: ImageOrderEnum.trending,
              child: ListTile(
                leading: Icon(Icons.local_fire_department_rounded),
                title: Text("Trending"),
              ),
            ),
          ];
        },
      );

  void _handelSortType(ImageOrderEnum value) {
    dataSortType = value;
    keys[_currentIndex].currentState?.getImage(dataSortType);
    setState(() {});
  }

  void _handelGotoSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
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
