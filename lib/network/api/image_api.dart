import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/network/base/base_api.dart';
import 'package:flutter_pixabay/network/constants.dart';
import 'package:flutter_pixabay/network/service/image_service.dart';

class ImageApi extends BaseApi {
  ImageTypeEnum mediaType = ImageTypeEnum.all;
  String apiPath = "";

  void initImageTypeUrl() {
    switch (mediaType) {
      case ImageTypeEnum.all:
        apiPath = "${apiKey}&image_type=all";
        break;
      case ImageTypeEnum.photo:
        apiPath = "${apiKey}&image_type=photo";
        break;
      case ImageTypeEnum.illustration:
        apiPath = "${apiKey}&image_type=illustration";
        break;
      case ImageTypeEnum.vector:
        apiPath = "${apiKey}&image_type=vector";
        break;
    }
  }


  @override
  String path() {
    return apiPath;
  }

  @override
  RequestMethod method() {
    return RequestMethod.get;
  }

  @override
  String serviceKey() {
    return imageServiceKey;
  }
}
