import 'package:flutter/material.dart';

class VideoResult extends StatefulWidget {
  VideoResult({Key? key, this.categoryTitle = ""}) : super(key: key);
  String categoryTitle;

  @override
  State<VideoResult> createState() => _VideoResultState();
}

class _VideoResultState extends State<VideoResult> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
