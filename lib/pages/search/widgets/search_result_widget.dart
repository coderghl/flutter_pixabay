import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';
import 'package:flutter_pixabay/widgets/image_lsit.dart';
import 'package:flutter_pixabay/widgets/video_list.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({
    super.key,
    required this.keyWords,
  });

  final String keyWords;

  @override
  State<SearchResultWidget> createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget>
    with TickerProviderStateMixin {
  late TabController _controller;

  List<String> tabTitles = [
    "Photo",
    "Illustration",
    "Vector",
    "Film",
    "Animation",
  ];

  @override
  void initState() {
    _controller = TabController(length: tabTitles.length, vsync: this);
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
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverPersistentHeader(
          floating: true,
          delegate: SearchResultTabBarDelegate(
            color: Theme.of(context).colorScheme.background,
            vsync: this,
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              tabs: tabTitles
                  .map(
                    (e) => Tab(
                      text: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: TabBarView(
          controller: _controller,
          children: [
            ImageList(
              type: ImageTypeEnum.photo,
              keyWords: widget.keyWords,
            ),
            ImageList(
              type: ImageTypeEnum.illustration,
              keyWords: widget.keyWords,
            ),
            ImageList(
              type: ImageTypeEnum.vector,
              keyWords: widget.keyWords,
            ),
            VideoList(
              type: VideoTypeEnum.film,
              keyWords: widget.keyWords,
            ),
            VideoList(
              type: VideoTypeEnum.animation,
              keyWords: widget.keyWords,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultTabBarDelegate extends SliverPersistentHeaderDelegate {
  SearchResultTabBarDelegate({
    required this.child,
    required this.vsync,
    required this.color,
  });
  final TickerProvider vsync;
  final TabBar child;
  final Color color;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(color: color, child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration =>
      FloatingHeaderSnapConfiguration();
}
