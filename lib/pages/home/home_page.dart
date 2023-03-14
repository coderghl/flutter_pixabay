import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/media_type_entity.dart';
import 'package:flutter_pixabay/enum/media_type_enum.dart';
import 'package:flutter_pixabay/enum/sort_enum.dart';
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
  List<MediaTypeEntity> mediaTypeList = [
    MediaTypeEntity(
        name: "All",
        type: MediaTypeEnum.all,
        iconData: Icons.all_inbox_rounded),
    MediaTypeEntity(
      name: "Photo",
      type: MediaTypeEnum.photo,
      iconData: Icons.photo_album_rounded,
    ),
    MediaTypeEntity(
      name: "Illustration",
      type: MediaTypeEnum.illustration,
      iconData: Icons.brush_rounded,
    ),
    MediaTypeEntity(
      name: "Vector",
      type: MediaTypeEnum.vector,
      iconData: Icons.landscape_rounded,
    ),
  ];

  /// data sort type
  SortEnum dataSortType = SortEnum.foryou;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: mediaTypeList.length,
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
      children: mediaTypeList
          .map((item) => KeepAliveWidget(
                wantKeepAlive: true,
                child: HomeTabPageWidget(type: item),
              ))
          .toList(),
    );
  }

  TabBar _buildTabBar() => TabBar(
      tabs: mediaTypeList
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
            PopupMenuItem<SortEnum>(
              value: SortEnum.foryou,
              child: ListTile(
                leading: Icon(Icons.recommend_rounded),
                title: Text("For you"),
              ),
            ),
            PopupMenuItem<SortEnum>(
              value: SortEnum.latest,
              child: ListTile(
                leading: Icon(Icons.fiber_new_rounded),
                title: Text("Latest"),
              ),
            ),
            PopupMenuItem<SortEnum>(
              value: SortEnum.trending,
              child: ListTile(
                leading: Icon(Icons.local_fire_department_rounded),
                title: Text("Trending"),
              ),
            ),
          ];
        },
      );

  void _handelSortType(SortEnum value) {
    dataSortType = value;
    setState(() {});
  }

  void _handelGotoSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }
}
