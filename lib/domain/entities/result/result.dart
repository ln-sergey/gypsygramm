import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../message/message.dart';
import '../room/room.dart';
import '../settings/settings.dart';

part 'result.g.dart';

@HiveType(typeId : 4)
class ResultHistory extends Equatable {
  @HiveField(0)
  final List<Message> result;

  ResultHistory(this.result);

  @override
  List<Object> get props => [result];
}

@HiveType(typeId : 5)
class ResultRooms extends Equatable {
  @HiveField(0)
  final List<Room> result;

  ResultRooms(this.result);

  @override
  List<Object> get props => [result];
}

@HiveType(typeId : 6)
class ResultSettings extends Equatable {
  @HiveField(0)
  final Settings result;

  ResultSettings(this.result);

  @override
  List<Object> get props => [result];
}
