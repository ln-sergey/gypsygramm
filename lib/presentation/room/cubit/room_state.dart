part of 'room_cubit.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final Stream<List<Message>> dataStream;
  final List<Message> initialData;

  RoomLoaded(this.dataStream, this.initialData);
}
