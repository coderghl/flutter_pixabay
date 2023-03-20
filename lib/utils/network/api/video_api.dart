import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';
import 'package:flutter_pixabay/utils/network/http/http.dart';

class VideoApi {
  void getVideo({
    required VideoTypeEnum type,
    required int page,
    required void Function(Map<String, dynamic> data) successCallback,
    required void Function(String error) errorCallback,
    String keyWords = "",
    VideoOrderEnum order = VideoOrderEnum.popular,
  }) {
    String resultType = _getVideoTypeUrl(type);
    String resultOrder = _getVideoOrder(order);
    String path = keyWords.isEmpty
        ? "video_type=$resultType&order=$resultOrder&page=$page"
        : "video_type=$resultType&q=$keyWords&page=$page";

    Http().request(
      path: path,
      successCallback: successCallback,
      errorCallback: errorCallback,
    );
  }

  String _getVideoOrder(VideoOrderEnum order) {
    String result = "popular";
    switch (order) {
      case VideoOrderEnum.popular:
        result = "popular";
        break;
      case VideoOrderEnum.latest:
        result = "latest";
        break;
    }
    return result;
  }

  String _getVideoTypeUrl(VideoTypeEnum mediaType) {
    String type = "all";
    switch (mediaType) {
      case VideoTypeEnum.all:
        type = "all";
        break;
      case VideoTypeEnum.film:
        type = "film";
        break;
      case VideoTypeEnum.animation:
        type = "animation";
        break;
    }
    return type;
  }
}
