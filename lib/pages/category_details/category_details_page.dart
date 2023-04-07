import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';
import 'package:flutter_pixabay/widgets/image_lsit.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';
import 'package:flutter_pixabay/widgets/video_list.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  final String categoryTitle;

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final List<String> _titles = ["Image", "Video"];
  late ScrollController _scrollController;

  @override
  void initState() {
    _controller = TabController(length: _titles.length, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: _handelBackTop,
        child: const Icon(Icons.arrow_upward_rounded),
      ),
      body: ExtendedNestedScrollView(
        controller: _scrollController,
        onlyOneScrollInBody: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text(widget.categoryTitle),
              bottom: _buildTabBar(),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: [
            KeepAliveWidget(
              child: ImageList(
                type: ImageTypeEnum.all,
                categoryTitle: widget.categoryTitle,
              ),
            ),
            KeepAliveWidget(
              child: VideoList(
                type: VideoTypeEnum.all,
                categoryTitle: widget.categoryTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _controller,
      tabs: [
        Tab(
          text: _titles.first,
          icon: const Icon(Icons.image_rounded),
        ),
        Tab(
          text: _titles.first,
          icon: const Icon(Icons.videocam_rounded),
        )
      ],
    );
  }

  void _handelBackTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
