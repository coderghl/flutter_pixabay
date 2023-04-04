
import 'package:hive/hive.dart';
part 'search_history_entity.g.dart';

@HiveType(typeId: 1)
class SearchHistoryEntity {
  SearchHistoryEntity({required this.keyWord});

  @HiveField(0)
  String keyWord;
}
