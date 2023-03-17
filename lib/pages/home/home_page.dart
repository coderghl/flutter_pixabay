import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/pages/home/widgets/home_tab_page_widget.dart';
import 'package:flutter_pixabay/pages/search/search_page.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  ImageOrderEnum dataSortType = ImageOrderEnum.foryou;

  int currentIndex = 0;

  List<GlobalKey<HomeTabPageWidgetState>> keys = [
    GlobalKey(debugLabel: "all"),
    GlobalKey(debugLabel: "photo"),
    GlobalKey(debugLabel: "illustration"),
    GlobalKey(debugLabel: "vector"),
  ];

  List<ImageTypeEntity> imageTypeList = [
    ImageTypeEntity(
        name: "All",
        type: ImageTypeEnum.all,
        iconData: Icons.all_inbox_rounded),
    ImageTypeEntity(
      name: "Photo",
      type: ImageTypeEnum.photo,
      iconData: Icons.photo_album_rounded,
    ),
    ImageTypeEntity(
      name: "Illustration",
      type: ImageTypeEnum.illustration,
      iconData: Icons.brush_rounded,
    ),
    ImageTypeEntity(
      name: "Vector",
      type: ImageTypeEnum.vector,
      iconData: Icons.landscape_rounded,
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: currentIndex,
      length: imageTypeList.length,
      vsync: this,
    );
    _pageController = PageController(initialPage: currentIndex);
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
          child: HomeTabPageWidget(
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
    keys[currentIndex].currentState?.getImage(dataSortType);
    setState(() {});
  }

  void _handelGotoSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  void _handelTabOnTap(int index) {
    currentIndex = index;
    _pageController.animateToPage(
      currentIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _handelPageChange(int index) {
    currentIndex = index;
    _tabController.animateTo(
      currentIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
