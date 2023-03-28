import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/provider/image_order_provider.dart';
import 'package:flutter_pixabay/widgets/image_lsit.dart';
import 'package:provider/provider.dart';

class ImageTabPageWidget extends StatefulWidget {
  const ImageTabPageWidget({
    super.key,
    required this.type,
  });

  final ImageTypeEntity type;

  @override
  State<ImageTabPageWidget> createState() => ImageTabPageWidgetState();
}

class ImageTabPageWidgetState extends State<ImageTabPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageOrderProvider>(
      builder: (context, value, child) => ImageList(
        type: widget.type.type,
        order: value.currentOrder,
      ),
    );
  }
}
