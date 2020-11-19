part of 'rooms_cubit.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsLoaded extends RoomsState {
  final Stream<List<Room>> dataStream;
  final List<Room> initialData;

  RoomsLoaded(this.dataStream, this.initialData);
}
