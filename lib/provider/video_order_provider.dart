import 'package:flutter/cupertino.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';

class VideoOrderProvider with ChangeNotifier{
  VideoOrderEnum currentOrder = VideoOrderEnum.popular;

  void setOrder(VideoOrderEnum newOrder) {
    currentOrder = newOrder;
    notifyListeners();
  }
}