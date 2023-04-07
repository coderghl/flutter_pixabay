// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheEntityAdapter extends TypeAdapter<CacheEntity> {
  @override
  final int typeId = 2;

  @override
  CacheEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheEntity(
      data: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CacheEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
