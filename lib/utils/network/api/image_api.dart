import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/utils/network/http/http.dart';

class ImageApi {
  void getImage({
    required ImageTypeEnum type,
    required int page,
    required void Function(Map<String, dynamic> data) successCallback,
    required void Function(String error) errorCallback,
    String keyWords = "",
    ImageOrderEnum order = ImageOrderEnum.foryou,
  }) {
    String resultType = _getImageTypeUrl(type);
    String resultOrder = _getImageOrder(order);
    String path = keyWords.isEmpty
        ? "image_type=$resultType&order=$resultOrder&page=$page"
        : "image_type=$resultType&q=$keyWords&page=$page";

    Http().request(
      path: path,
      successCallback: successCallback,
      errorCallback: errorCallback,
    );
  }

  String _getImageOrder(ImageOrderEnum order) {
    String result = "foryou";
    switch (order) {
      case ImageOrderEnum.foryou:
        result = "foryou";
        break;
      case ImageOrderEnum.latest:
        result = "latest";
        break;
      case ImageOrderEnum.trending:
        result = "trending";
        break;
    }
    return result;
  }

  String _getImageTypeUrl(ImageTypeEnum mediaType) {
    String type = "all";
    switch (mediaType) {
      case ImageTypeEnum.all:
        type = "all";
        break;
      case ImageTypeEnum.photo:
        type = "photo";
        break;
      case ImageTypeEnum.illustration:
        type = "illustration";
        break;
      case ImageTypeEnum.vector:
        type = "vector";
        break;
    }
    return type;
  }
}
