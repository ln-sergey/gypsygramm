// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    json['room'] as String,
    json['text'] as String,
    json['id'] as String,
    json['created'] as String,
    json['sender'] == null
        ? null
        : SenderModel.fromJson(json['sender'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'room': instance.room,
      'text': instance.text,
      'id': instance.id,
      'created': instance.created,
      'sender': instance.senderModel?.toJson(),
    };
