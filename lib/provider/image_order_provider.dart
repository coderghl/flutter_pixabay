import 'package:flutter/material.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';

class ImageOrderProvider with ChangeNotifier {
  ImageOrderEnum currentOrder = ImageOrderEnum.foryou;

  void setOrder(ImageOrderEnum newOrder) {
    currentOrder = newOrder;
    notifyListeners();
  }
}
