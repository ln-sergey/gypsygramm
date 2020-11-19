// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModelHistory _$ResultModelHistoryFromJson(Map<String, dynamic> json) {
  return ResultModelHistory(
    (json['result'] as List)
        ?.map((e) =>
            e == null ? null : MessageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultModelHistoryToJson(ResultModelHistory instance) =>
    <String, dynamic>{
      'result': instance.resultModel?.map((e) => e?.toJson())?.toList(),
    };

ResultModelRooms _$ResultModelRoomsFromJson(Map<String, dynamic> json) {
  return ResultModelRooms(
    (json['result'] as List)
        ?.map((e) =>
            e == null ? null : RoomModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultModelRoomsToJson(ResultModelRooms instance) =>
    <String, dynamic>{
      'result': instance.resultModel?.map((e) => e?.toJson())?.toList(),
    };

ResultModelSettings _$ResultModelSettingsFromJson(Map<String, dynamic> json) {
  return ResultModelSettings(
    json['result'] == null
        ? null
        : SettingsModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultModelSettingsToJson(
        ResultModelSettings instance) =>
    <String, dynamic>{
      'result': instance.resultModel?.toJson(),
    };
