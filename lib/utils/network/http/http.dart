import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_pixabay/utils/constants.dart';

enum RequestMethod { get, post, put, delete, patch, copy }

class Http {
  static final Http _instants = Http._internal();

  factory Http() => _instants;

  late Dio _dio;

  Http._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "$kBaseUrl$kApiKey&",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    _dio = Dio(options);
  }

  void request({
    required String path,
    Options? options,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    RequestMethod method = RequestMethod.get,
    required void Function(Map<String, dynamic> data) successCallback,
    required void Function(String error) errorCallback,
  }) async {
    Response? response;
    try {
      switch (method) {
        case RequestMethod.get:
          response = await _dio.get(path,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestMethod.post:
          response = await _dio.post(path,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestMethod.put:
          // TODO: Handle this case.
          break;
        case RequestMethod.delete:
          // TODO: Handle this case.
          break;
        case RequestMethod.patch:
          // TODO: Handle this case.
          break;
        case RequestMethod.copy:
          // TODO: Handle this case.
          break;
      }
    } on DioError catch (error) {
      errorCallback(errorFactory(error));
    }

    if (response != null && response.data != null) {
      String dataStr = json.encode(response.data);
      Map<String, dynamic> data = json.decode(dataStr);
      successCallback(data);
    }
  }

  String errorFactory(DioError error) {
    String errorMessage = error.message ?? "";
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        errorMessage = "Connection timeout";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive timeout";
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Send timeout";
        break;
      case DioErrorType.badCertificate:
        errorMessage = "No certificate";
        break;
      case DioErrorType.badResponse:
        errorMessage = "Bed Response";
        break;
      case DioErrorType.cancel:
        errorMessage = "Canceled";
        break;
      case DioErrorType.connectionError:
        errorMessage = "Connect error";
        break;
      case DioErrorType.unknown:
        errorMessage = "unknown";
        break;
    }
    return errorMessage;
  }
}
