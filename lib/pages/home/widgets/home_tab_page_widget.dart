import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/media_type_entity.dart';
import 'package:flutter_pixabay/widgets/list_tile_m3_widget.dart';

class HomeTabPageWidget extends StatefulWidget {
  const HomeTabPageWidget({
    super.key,
    required this.type,
  });

  final MediaTypeEntity type;

  @override
  State<HomeTabPageWidget> createState() => _HomeTabPageWidgetState();
}

class _HomeTabPageWidgetState extends State<HomeTabPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
        ),
        itemCount: 100,
        itemBuilder: (context, index) => ListTileM3Widget(
          title: Text("Item $index"),
        ),
      ),
    );
  }
}
