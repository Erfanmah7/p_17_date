// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class todoAdapter extends TypeAdapter<todo> {
  @override
  final int typeId = 1;

  @override
  todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return todo()
      ..title = fields[0] as String
      ..descript = fields[1] as String
      ..date = fields[2] as String
      ..time = fields[3] as String
      ..fullname = fields[4] as String
      ..user = fields[5] as String
      ..password = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, todo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.descript)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.fullname)
      ..writeByte(5)
      ..write(obj.user)
      ..writeByte(6)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is todoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
