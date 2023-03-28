import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_type_entity.dart';
import 'package:flutter_pixabay/provider/video_order_provider.dart';
import 'package:flutter_pixabay/widgets/video_list.dart';
import 'package:provider/provider.dart';

class VideoTabPageWidget extends StatefulWidget {
  const VideoTabPageWidget({
    Key? key,
    required this.type,
  }) : super(key: key);
  final VideoTypeEntity type;

  @override
  State<VideoTabPageWidget> createState() => VideoTabPageWidgetState();
}

class VideoTabPageWidgetState extends State<VideoTabPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VideoOrderProvider>(
      builder: (context, value, child) => VideoList(
        type: widget.type.type,
        order: value.currentOrder,
      ),
    );
  }
}
