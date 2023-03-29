import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_type_entity.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/pages/search/search_page.dart';
import 'package:flutter_pixabay/pages/video/widget/video_tab_page_widget.dart';
import 'package:flutter_pixabay/provider/video_order_provider.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  VideoOrderProvider videoOrderProvider = VideoOrderProvider();

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: videoTypeList.length,
      vsync: this,
    );
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
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            title: const Text("Video"),
            bottom: _buildTabBar(),
            actions: [
              _buildSearchBtn(),
              _buildPopupMenu(),
            ],
          ),
        ];
      },
      body: ChangeNotifierProvider<VideoOrderProvider>.value(
        value: videoOrderProvider,
        builder: (context, child) => _buildTabBarView(),
      ),
    );
  }

  TabBar _buildTabBar() => TabBar(
      controller: _tabController,
      tabs: videoTypeList
          .map((item) => Tab(text: item.name, icon: Icon(item.iconData)))
          .toList());

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: List.generate(
        videoTypeList.length,
        (index) => KeepAliveWidget(
          wantKeepAlive: true,
          child: VideoTabPageWidget(
            type: videoTypeList[index],
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildSearchBtn() => IconButton(
        onPressed: _handelGotoSearchPage,
        icon: const Icon(Icons.search_rounded),
      );

  Widget _buildPopupMenu() => PopupMenuButton(
        initialValue: videoOrderProvider.currentOrder,
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

  void _handelSortType(VideoOrderEnum newOrder) {
    videoOrderProvider.setOrder(newOrder);
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
}
