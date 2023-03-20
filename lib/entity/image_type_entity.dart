import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';

class ImageTypeEntity {
  ImageTypeEntity({
    required this.name,
    required this.type,
    this.iconData,
  });

  final String name;
  final ImageTypeEnum type;
  IconData? iconData;
}

List<ImageTypeEntity> imageTypeList = [
  ImageTypeEntity(
    name: "All",
    type: ImageTypeEnum.all,
    iconData: Icons.all_inbox_rounded,
  ),
  ImageTypeEntity(
    name: "Photo",
    type: ImageTypeEnum.photo,
    iconData: Icons.photo_album_rounded,
  ),
  ImageTypeEntity(
    name: "Illustration",
    type: ImageTypeEnum.illustration,
    iconData: Icons.brush_rounded,
  ),
  ImageTypeEntity(
    name: "Vector",
    type: ImageTypeEnum.vector,
    iconData: Icons.landscape_rounded,
  ),
];
