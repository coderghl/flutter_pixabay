import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_pixabay/network/base/service.dart';
import 'package:flutter_pixabay/network/base/service_manager.dart';

enum RequestMethod { get, post, put, delete, patch, copy }

class BaseApi {
  String serviceKey() => "";

  String path() => "";

  RequestMethod method() => RequestMethod.get;

  void request({
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    required Function successCallback,
    required Function errorCallback,
  }) async {
    /// 获取服务
    Service service;
    if (ServiceManager().serviceMap.containsKey(serviceKey())) {
      service = ServiceManager().serviceMap[serviceKey()]!;
    } else {
      throw Exception("No Register Service");
    }

    Dio dio = service.dio;

    Response? response;

    Map<String, dynamic>? queryParams = {};
    var globalQueryParams = service.serviceQuery();
    if (globalQueryParams != null) queryParams.addAll(globalQueryParams);
    if (query != null) queryParams.addAll(query);

    Map<String, dynamic>? headerParams = {};
    var globalHeaderParams = service.serviceHeader();
    if (globalHeaderParams != null) headerParams.addAll(globalHeaderParams);
    if (header != null) headerParams.addAll(header);

    Map<String, dynamic>? bodyParams = {};
    var globalBodyParams = service.serviceBody();
    if (globalBodyParams != null) bodyParams.addAll(globalBodyParams);
    if (body != null) bodyParams.addAll(body);

    String url = path();

    Options options = Options(headers: headerParams);
    try {
      switch (method()) {
        case RequestMethod.get:
          if (queryParams.isNotEmpty) {
            response = await dio.get(url, queryParameters: queryParams, options: options);
          } else {
            response = await dio.get(url, options: options);
          }
          break;
        case RequestMethod.post:
          if (body != null && body.isNotEmpty) {
            response = await dio.post(url, data: body, options: options);
          } else {
            response = await dio.post(url, options: options);
          }
          break;
      }
    } on DioError catch (error) {
      errorCallback(service.errorFactory(error));
    }

    if (response != null && response.data != null) {
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      dataMap = service.responseFactory(dataMap);
      successCallback(dataMap);
    }
  }
}
