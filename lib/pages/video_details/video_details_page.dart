import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final VideoEntity data;

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
