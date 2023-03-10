import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap(int index) {
    _currentIndex = index;
    _controller.animateTo(_currentIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: const Text("Pixabay"),
      bottom: TabBar(
        controller: _controller,
        onTap: onTap,
        tabs: const [
          Tab(
            text: "All",
            icon: Icon(Icons.all_inbox_rounded),
          ),
          Tab(
            text: "Photo",
            icon: Icon(Icons.photo_album_rounded),
          ),
          Tab(
            text: "Illustration",
            icon: Icon(Icons.brush_rounded),
          ),
          Tab(
            text: "Vector",
            icon: Icon(Icons.landscape_rounded),
          ),
        ],
      ),
      actions: [
        Hero(
          tag: "searchIcon",
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
          ),
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.recommend_rounded),
                  title: Text("For you"),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.fiber_new_rounded),
                  title: Text("Latest"),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.local_fire_department_rounded),
                  title: Text("Trending"),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
