import 'package:equatable/equatable.dart';
import 'package:gypsygramm/domain/entities/settings/settings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingsModel extends Settings {
  @JsonKey(name: 'max_message_length')
  int maxMessageLength;
  @JsonKey(name: 'max_room_title_length')
  int maxRoomTitleLength;
  @JsonKey(name: 'max_username_length')
  int maxUsernameLength;
  @JsonKey(name: 'uptime')
  int uptime;

  SettingsModel(this.maxMessageLength, this.maxRoomTitleLength,
      this.maxUsernameLength, this.uptime)
      : super(maxMessageLength, maxRoomTitleLength, maxUsernameLength, uptime);

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  @override
  List<Object> get props =>
      [maxMessageLength, maxRoomTitleLength, maxUsernameLength, uptime];
}
