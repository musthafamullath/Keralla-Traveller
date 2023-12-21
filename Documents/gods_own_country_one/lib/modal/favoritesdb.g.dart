// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritesdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesdbAdapter extends TypeAdapter<Favoritesdb> {
  @override
  final int typeId = 3;

  @override
  Favoritesdb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favoritesdb(
      userId: fields[0] as int,
      countryId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Favoritesdb obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.countryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesdbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
