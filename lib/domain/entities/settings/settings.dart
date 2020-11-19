import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final int maxMessageLength;
  final int maxRoomTitleLength;
  final int maxUsernameLength;
  final int uptime;

  Settings(this.maxMessageLength, this.maxRoomTitleLength,
      this.maxUsernameLength, this.uptime);

  @override
  List<Object> get props =>
      [maxMessageLength, maxRoomTitleLength, maxUsernameLength, uptime];
}
