import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/pages/image/widgets/image_tab_page_widget.dart';
import 'package:flutter_pixabay/pages/search/search_page.dart';
import 'package:flutter_pixabay/provider/image_order_provider.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentIndex = 0;
  ImageOrderProvider imageOrderProvider = ImageOrderProvider();

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: _currentIndex,
      length: imageTypeList.length,
      vsync: this,
    );
    _tabController.addListener(() {
      _handelPageChange();
    });
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
            title: const Text("Image"),
            bottom: _buildTabBar(),
            actions: [
              _buildSearchBtn(),
              _buildPopupMenu(),
            ],
          ),
        ];
      },
      body: ChangeNotifierProvider<ImageOrderProvider>.value(
        value: imageOrderProvider,
        builder: (context, child) => _buildTabBarView(),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: List.generate(
        imageTypeList.length,
        (index) => KeepAliveWidget(
          wantKeepAlive: true,
          child: ImageTabPageWidget(
            type: imageTypeList[index],
          ),
        ),
      ).toList(),
    );
  }

  TabBar _buildTabBar() => TabBar(
      controller: _tabController,
      tabs: imageTypeList
          .map((item) => Tab(text: item.name, icon: Icon(item.iconData)))
          .toList());

  Widget _buildSearchBtn() => IconButton(
        onPressed: _handelGotoSearchPage,
        icon: const Icon(Icons.search_rounded),
      );

  Widget _buildPopupMenu() => PopupMenuButton(
        initialValue: imageOrderProvider.currentOrder,
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

  void _handelSortType(ImageOrderEnum newOrder) {
    imageOrderProvider.setOrder(newOrder);
    setState(() {});
  }

  void _handelGotoSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  void _handelPageChange() {
    _currentIndex = _tabController.index;
  }
}
