import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';
import 'package:flutter_pixabay/widgets/video_list.dart';

class VideoResult extends StatelessWidget {
  VideoResult({Key? key, this.categoryTitle = ""}) : super(key: key);
  String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return VideoList(
      type: VideoTypeEnum.all,
      categoryTitle: categoryTitle,
    );
  }
}
