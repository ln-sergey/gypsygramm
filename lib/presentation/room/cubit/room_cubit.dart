import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/message/message.dart';
import '../../../domain/repositories/room_repository.dart';
import '../../authentification/cubit/authentification_cubit.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final AuthentificationCubit _authentificationCubit;
  final RoomRepository _repository;
  final String roomName;

  RoomCubit(this._authentificationCubit, this._repository, this.roomName)
      : super(RoomInitial());

  Future loadMessages() async {
    if (_authentificationCubit.state.isOnline) {
      emit(RoomLoading());
      await _repository.setDataStreamListener(roomName);
      try {
        await _repository.loadMessagesFromApi(Uri.encodeComponent(roomName));
      } on Exception {
        emit(RoomLoaded(
            await _repository.getMessagesStream(roomName), <Message>[]));
      }
    }
    emit(RoomLoaded(await _repository.getMessagesStream(roomName),
        await _repository.loadMessagesFromStorage(roomName)));
  }

  void sendMessage(String text) => _repository.sendMessage(roomName, text);

  Future<void> dispose() async {
    await _repository.closeSubscription();
    _repository.closeLocalStorage(roomName);
  }
}
