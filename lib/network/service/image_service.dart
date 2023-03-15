import 'package:flutter_pixabay/network/base/service.dart';

const String imageServiceKey = "homeServiceKey";

class ImageService extends Service {
  @override
  String serviceKey() {
    return imageServiceKey;
  }

  @override
  void initDio() {
    dio.options.baseUrl = "https://pixabay.com/api/?key=";
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
  }

  @override
  Map<String, dynamic> responseFactory(Map<String, dynamic> dataMap) {
    return dataMap;
  }
}
