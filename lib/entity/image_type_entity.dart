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
