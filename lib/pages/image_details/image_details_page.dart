import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';

class ImageDetailsPage extends StatefulWidget {
  const ImageDetailsPage({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final List<ImageEntity> data;
  final int index;

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  late PageController controller;
  int _index = 0;

  @override
  void initState() {
    _index = widget.index;
    controller = PageController(initialPage: _index);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: widget.data.length,
              onPageChanged: (index) {
                _index = index;
                setState(() {});
              },
              itemBuilder: (context, index) {
                var image = widget.data[index];
                return Hero(
                  tag: image.webformatUrl!,
                  child: InteractiveViewer(
                    maxScale: 5,
                    minScale: 1,
                    child: Image.network(image.webformatUrl!),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text("$_index/${widget.data.length}"),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
