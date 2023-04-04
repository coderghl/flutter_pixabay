// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchHistoryEntityAdapter extends TypeAdapter<SearchHistoryEntity> {
  @override
  final int typeId = 1;

  @override
  SearchHistoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchHistoryEntity(
      keyWord: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchHistoryEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.keyWord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchHistoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
