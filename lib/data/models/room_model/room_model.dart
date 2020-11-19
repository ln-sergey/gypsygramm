import 'package:equatable/equatable.dart';
import 'package:gypsygramm/data/models/message_model/message_model.dart';
import 'package:gypsygramm/domain/entities/room/room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomModel extends Room {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'last_message')
  MessageModel lastMessageModel;

  RoomModel(this.name, this.lastMessageModel) : super(name, lastMessageModel);

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  @override
  List<Object> get props => [name, lastMessageModel];
}
