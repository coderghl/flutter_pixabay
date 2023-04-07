import 'package:hive/hive.dart';
part 'cache_entity.g.dart';

@HiveType(typeId: 2)
class CacheEntity {
  CacheEntity({required this.data});

  @HiveField(0)
  String data;
}
