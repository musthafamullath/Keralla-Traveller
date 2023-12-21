// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addtohomeadmin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddToHomeAdminAdapter extends TypeAdapter<AddToHomeAdmin> {
  @override
  final int typeId = 2;

  @override
  AddToHomeAdmin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddToHomeAdmin(
      image: fields[4] as String,
      place: fields[1] as String,
      location: fields[2] as String,
      details: fields[3] as String,
      categories: fields[5] as String,
      rating: fields[6] as double,
      key: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddToHomeAdmin obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.place)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddToHomeAdminAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
