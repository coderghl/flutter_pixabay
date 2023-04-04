import 'package:flutter_pixabay/entity/search_history_entity.dart';
import 'package:flutter_pixabay/utils/constants.dart';
import 'package:hive/hive.dart';

class SearchBox {
  static final SearchBox _instants = SearchBox._internal();

  factory SearchBox() => _instants;

  SearchBox._internal();

  late final Box box;

  void init() {
    box = Hive.box(kSearchBox);
  }

  void addKeyWord(String keyWord) {
    for (SearchHistoryEntity element in box.values) {
      if (element.keyWord == keyWord) {
        return;
      }
    }

    if (box.length == kMaxSearchHistoryLength) {
      box.deleteAt(0);
    }

    box.add(SearchHistoryEntity(keyWord: keyWord));
  }

  void removeKeyWord(int index) {
    box.deleteAt(index);
  }

  void removeAllKeyWord() {
    box.clear();
  }
}
