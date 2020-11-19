import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/result/result.dart';
import '../message_model/message_model.dart';
import '../room_model/room_model.dart';
import '../settings_model/settings_model.dart';

part 'result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultModelHistory extends ResultHistory {
  @JsonKey(name: 'result')
  List<MessageModel> resultModel;

  ResultModelHistory(this.resultModel) : super(resultModel);

  factory ResultModelHistory.fromJson(Map<String, dynamic> json) =>
      _$ResultModelHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelHistoryToJson(this);

  @override
  List<Object> get props => [result];
}

@JsonSerializable(explicitToJson: true)
class ResultModelRooms extends ResultRooms {
  @JsonKey(name: 'result')
  List<RoomModel> resultModel;

  ResultModelRooms(this.resultModel) : super(resultModel);

  factory ResultModelRooms.fromJson(Map<String, dynamic> json) =>
      _$ResultModelRoomsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelRoomsToJson(this);

  @override
  List<Object> get props => [result];
}

@JsonSerializable(explicitToJson: true)
class ResultModelSettings extends ResultSettings {
  @JsonKey(name: 'result')
  SettingsModel resultModel;

  ResultModelSettings(this.resultModel) : super(resultModel);

  factory ResultModelSettings.fromJson(Map<String, dynamic> json) =>
      _$ResultModelSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelSettingsToJson(this);

  @override
  List<Object> get props => [result];
}
