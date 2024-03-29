// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wisaally_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WisaallyHiveAdapter extends TypeAdapter<WisaallyHive> {
  @override
  final int typeId = 4;

  @override
  WisaallyHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WisaallyHive(
      strtwisaally: fields[3] as bool,
      cabwisaally: fields[2] as String,
      logwisaally: fields[1] as String,
      regwisaally: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WisaallyHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.regwisaally)
      ..writeByte(1)
      ..write(obj.logwisaally)
      ..writeByte(2)
      ..write(obj.cabwisaally)
      ..writeByte(3)
      ..write(obj.strtwisaally);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WisaallyHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
