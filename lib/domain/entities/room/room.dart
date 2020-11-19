import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../message/message.dart';

part 'room.g.dart';

@HiveType(typeId : 3)
class Room extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Message lastMessage;

  Room(this.name, this.lastMessage);

  @override
  List<Object> get props => [name, lastMessage];
}
