import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static final SharedPreferencesUtil _instants =
      SharedPreferencesUtil._internal();

  factory SharedPreferencesUtil() => _instants;

  SharedPreferencesUtil._internal();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getBool(String key) => _prefs.getBool(key) ?? false;

  Future<bool> setString(String key, dynamic value) async {
    return await _prefs.setString(key, value);
  }

  String getString(String key) => _prefs.getString(key) ?? "";

  dynamic getJson(String key) => jsonDecode(_prefs.getString(key) ?? "");

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
