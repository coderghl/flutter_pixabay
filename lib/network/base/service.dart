import 'package:dio/dio.dart';

class Service {
  final Dio dio = Dio();

  String _baseUrl = "";

  set baseUrl(value) {
    if (_baseUrl == value) return;
    _baseUrl = value;
    dio.options.baseUrl = _baseUrl;
  }

  get baseUrl => _baseUrl;

  String serviceKey() => "";

  void initDio() {}

  Map<String, dynamic>? serviceHeader() {
    return null;
  }

  Map<String, dynamic>? serviceQuery() {
    return null;
  }

  Map<String, dynamic>? serviceBody() {
    return null;
  }

  Map<String, dynamic> responseFactory(Map<String, dynamic> dataMap) {
    return dataMap;
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
