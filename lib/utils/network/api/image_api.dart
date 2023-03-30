import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/utils/constants.dart';
import 'package:flutter_pixabay/utils/network/http/http.dart';

class ImageApi {
  void getImage({
    required int page,
    required ImageTypeEnum type,
    required void Function(Map<String, dynamic> data) successCallback,
    required void Function(String error) errorCallback,
    String keyWords = "",
    String category = "",
    ImageOrderEnum order = ImageOrderEnum.foryou,
  }) {
    String resultType = _getImageTypeUrl(type);
    String resultOrder = _getImageOrder(order);
    String path = "";
    if (keyWords.isNotEmpty) path += "&q=$keyWords";
    if (category.isNotEmpty) path += "&category=$category";

    path += "&image_type=$resultType";
    path += "&order=$resultOrder";
    path += "&page=$page";
    path += "&per_page=$kPerPage";

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
