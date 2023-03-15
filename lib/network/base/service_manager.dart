import 'package:flutter_pixabay/network/base/service.dart';

class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();

  factory ServiceManager() => _instance;

  Map<String, Service> serviceMap = {};

  ServiceManager._internal() {
    init();
  }

  void init() {}

  void registerService(Service service) {
    service.initDio();
    String key = service.serviceKey();
    serviceMap[key] = service;
  }
}
