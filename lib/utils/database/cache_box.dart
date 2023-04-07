import 'package:dio/dio.dart';
import 'package:flutter_pixabay/global.dart';
import 'package:flutter_pixabay/utils/constants.dart';
import 'package:hive/hive.dart';

class CacheBox {
  static final CacheBox _instants = CacheBox._internal();

  factory CacheBox() => _instants;

  CacheBox._internal();

  late Box _cacheBox;

  void init() {
    _cacheBox = Hive.box(kCacheBox);
  }

  void put(String key, String data) {
    _cacheBox.put(key, data);
  }

  String? get(String key) => _cacheBox.get(key);

  Future<int> clearCache() async {
    return await _cacheBox.clear();
  }
}
