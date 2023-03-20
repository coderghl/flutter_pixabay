import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';

class VideoTypeEntity {
  VideoTypeEntity({
    required this.name,
    required this.type,
    this.iconData,
  });

  final String name;
  final VideoTypeEnum type;
  IconData? iconData;
}

List<VideoTypeEntity> videoTypeList = [
  VideoTypeEntity(
    name: "all",
    type: VideoTypeEnum.all,
    iconData: Icons.all_inbox_rounded,
  ),
  VideoTypeEntity(
    name: "film",
    type: VideoTypeEnum.film,
    iconData: Icons.tv_rounded
  ),
  VideoTypeEntity(
    name: "animation",
    type: VideoTypeEnum.animation,
    iconData: Icons.animation_rounded,
  ),
];
