// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultHistoryAdapter extends TypeAdapter<ResultHistory> {
  @override
  final int typeId = 4;

  @override
  ResultHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultHistory(
      (fields[0] as List)?.cast<Message>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResultHistory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultRoomsAdapter extends TypeAdapter<ResultRooms> {
  @override
  final int typeId = 5;

  @override
  ResultRooms read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultRooms(
      (fields[0] as List)?.cast<Room>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResultRooms obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultRoomsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultSettingsAdapter extends TypeAdapter<ResultSettings> {
  @override
  final int typeId = 6;

  @override
  ResultSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultSettings(
      fields[0] as Settings,
    );
  }

  @override
  void write(BinaryWriter writer, ResultSettings obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
