import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'sender.g.dart';

@HiveType(typeId : 1)
class Sender extends Equatable{
  @HiveField(0)
  final String username;

  Sender(this.username);

  @override
  List<Object> get props => [username];
}
