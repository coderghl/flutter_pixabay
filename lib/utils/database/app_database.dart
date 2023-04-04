import 'package:flutter_pixabay/entity/search_history_entity.dart';
import 'package:flutter_pixabay/utils/constants.dart';
import 'package:flutter_pixabay/utils/database/search_box.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDatabase {
  static final AppDatabase _instants = AppDatabase._internal();

  factory AppDatabase() => _instants;

  AppDatabase._internal();

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SearchHistoryEntityAdapter());
    await Hive.openBox(kSearchBox);
    SearchBox().init();
  }
}
