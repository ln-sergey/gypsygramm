// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return RoomModel(
    json['name'] as String,
    json['last_message'] == null
        ? null
        : MessageModel.fromJson(json['last_message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'name': instance.name,
      'last_message': instance.lastMessageModel?.toJson(),
    };
