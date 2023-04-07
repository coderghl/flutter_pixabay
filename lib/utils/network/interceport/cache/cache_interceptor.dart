import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_pixabay/utils/database/cache_box.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor({this.maxAge = 3600});

  final int maxAge;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method.toLowerCase() == 'get') {
      final key = options.uri.toString();
      final dataString = CacheBox().get(key);
      if (dataString != null) {
        var data = jsonDecode(dataString);
        final response = Response(
          requestOptions: options,
          data: jsonDecode(data["data"]),
        );

        int dataDate = int.parse(data["date"].toString());
        var resultTime = DateTime.now().millisecondsSinceEpoch - dataDate;
        if (resultTime / 1000 < maxAge) {
          return handler.resolve(response);
        }
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.method.toLowerCase() == 'get') {
      final key = response.requestOptions.uri.toString();
      Map<String, dynamic> data = {
        "date": DateTime.now().millisecondsSinceEpoch,
        "data": jsonEncode(response.data)
      };
      final cacheData = jsonEncode(data);
      CacheBox().put(key, cacheData);
    }
    return super.onResponse(response, handler);
  }
}
