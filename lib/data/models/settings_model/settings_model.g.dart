// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) {
  return SettingsModel(
    json['max_message_length'] as int,
    json['max_room_title_length'] as int,
    json['max_username_length'] as int,
    json['uptime'] as int,
  );
}

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'max_message_length': instance.maxMessageLength,
      'max_room_title_length': instance.maxRoomTitleLength,
      'max_username_length': instance.maxUsernameLength,
      'uptime': instance.uptime,
    };
