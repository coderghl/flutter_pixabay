import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/widgets/image_lsit.dart';

class ImageResultWidget extends StatelessWidget {
  const ImageResultWidget({Key? key, required this.categoryTitle})
      : super(key: key);
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return ImageList(type: ImageTypeEnum.all);
  }
}
