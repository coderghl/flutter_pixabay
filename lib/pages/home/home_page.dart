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
  /// each tab type
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

  /// data sort type
  ImageOrderEnum dataSortType = ImageOrderEnum.foryou;

  /// imageType
  int currentImageType = 0;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: imageTypeList.length,
      child: ExtendedNestedScrollView(
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
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: imageTypeList
          .map((item) => KeepAliveWidget(
                wantKeepAlive: true,
                child: HomeTabPageWidget(type: item),
              ))
          .toList(),
    );
  }

  TabBar _buildTabBar() => TabBar(
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
    setState(() {});
  }

  void _handelGotoSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  void _handelTabOnTap(int index) {
    currentImageType = index;
  }
}
