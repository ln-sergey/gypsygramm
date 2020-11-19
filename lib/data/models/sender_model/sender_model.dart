import 'package:equatable/equatable.dart';
import 'package:gypsygramm/domain/entities/sender/sender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sender_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SenderModel extends Sender {
  @JsonKey(name: 'username')
  String username;

  SenderModel(this.username) : super(username);

  factory SenderModel.fromJson(Map<String, dynamic> json) =>
      _$SenderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SenderModelToJson(this);

  @override
  List<Object> get props => [username];
}
