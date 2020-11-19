import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../sender/sender.dart';

part 'message.g.dart';

@HiveType(typeId : 2)
class Message extends Equatable {
  @HiveField(0)
  final String room;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String created;
  @HiveField(4)
  final Sender sender;

  Message(this.room, this.text, this.id, this.created, this.sender);
  
  @override
  List<Object> get props => [room, text, id, created, sender];
}
