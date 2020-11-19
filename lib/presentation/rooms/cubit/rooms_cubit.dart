import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/room/room.dart';
import '../../../domain/repositories/rooms_repository.dart';
import '../../authentification/cubit/authentification_cubit.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final AuthentificationCubit _authentificationCubit;
  final RoomsRepository _repository;

  RoomsCubit(this._authentificationCubit, this._repository)
      : super(RoomsInitial());

  Future loadRooms() async {
    if (_authentificationCubit.state.isOnline) {
      emit(RoomsLoading());
      await _repository.loadRoomsFromApi();
      await _repository.setDataStreamListener();
    }
    emit(RoomsLoaded(await _repository.getRoomsStream(),
        await _repository.loadRoomsFromStorage()));
  }

  Future<void> closeSubscription() async {
    await _repository.closeSubscription();
  }

  void dispose() {
    _repository.closeDataStream();
    _repository.closeLocalStorage();
  }
}
