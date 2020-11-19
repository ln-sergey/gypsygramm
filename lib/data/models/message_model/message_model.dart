import 'package:gypsygramm/data/models/sender_model/sender_model.dart';
import 'package:gypsygramm/domain/entities/message/message.dart';
import 'package:gypsygramm/domain/entities/sender/sender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageModel extends Message {
  @JsonKey(name: 'room')
  String room;
  @JsonKey(name: 'text')
  String text;
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'created')
  String created;
  @JsonKey(name: 'sender')
  SenderModel senderModel;

  MessageModel(
      this.room, this.text, this.id, this.created, this.senderModel)
      : super(room, text, id, created, senderModel);

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  List<Object> get props => [room, text, id, created, sender];
}
