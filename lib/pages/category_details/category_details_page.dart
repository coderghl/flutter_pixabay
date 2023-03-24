import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/category_details/widget/image_result.dart';
import 'package:flutter_pixabay/pages/category_details/widget/video_result.dart';
import 'package:flutter_pixabay/widgets/keep_alive_widget.dart';

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

  @override
  void initState() {
    _controller = TabController(length: _titles.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      onlyOneScrollInBody: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text(widget.categoryTitle),
            bottom: _buildTabBar(),
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: [
          KeepAliveWidget(
            child: ImageResultWidget(categoryTitle: widget.categoryTitle),
          ),
          KeepAliveWidget(
            child: VideoResult(categoryTitle: widget.categoryTitle),
          ),
        ],
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
}
