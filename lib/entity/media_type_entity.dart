import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/media_type_enum.dart';

class MediaTypeEntity {
  MediaTypeEntity({
    required this.name,
    required this.type,
    this.iconData,
  });

  final String name;
  final MediaTypeEnum type;
  IconData? iconData;
}
