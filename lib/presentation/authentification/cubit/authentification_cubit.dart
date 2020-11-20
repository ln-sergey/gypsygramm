import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../data/errors/exceptions.dart';
import '../../../data/remote/connectivity_listener.dart';
import '../../../domain/entities/settings/settings.dart';
import '../../../domain/repositories/authentification_repository.dart';

part 'authentification_state.dart';

@injectable
class AuthentificationCubit extends Cubit<AuthentificationState> {
  final AuthentificationRepository _repository;
  final ConnectivityListener _connectivityListener;

  StreamSubscription<ConnectionStatus> _connectivitySubscription;
  Settings _settings;
  Settings get settings => _settings;

  final VALIDATION_FAILURE_MESSAGE =
      'Username is too long. Try enter shorter one.';

  AuthentificationCubit(this._repository, this._connectivityListener)
      : super(AuthentificationInitial(true));

  Future<void> init() async {
    if ((await _setConnectionListener()) == ConnectionStatus.disconnected)
      return;
    try {
      _settings = await _repository.getSettings();
      await _repository.getDataStream();
      emit(AuthentificationLoggedIn(
          state.isOnline, await _repository.getUsername()));
    } on CacheException {
      emit(AuthentificationNotLoggedIn(state.isOnline));
    } on HttpException catch (e) {
      emit(AuthentificationNotLoggedIn(state.isOnline, e.message));
    }
  }

  Future signIn({@required String username}) async {
    if (!_usernameValidation(username)) {
      emit(AuthentificationNotLoggedIn(
          state.isOnline, VALIDATION_FAILURE_MESSAGE));
      return;
    }
    try {
      await _repository.getDataStream(username: username);
      emit(AuthentificationLoggedIn(state.isOnline, username));
    } on ServerException catch (e) {
      emit(AuthentificationNotLoggedIn(state.isOnline, e.message));
    } on Exception catch (e) {
      emit(AuthentificationNotLoggedIn(state.isOnline, e.toString()));
    }
  }

  Future signOut() async {
    await _repository.signOutUser();
    emit(AuthentificationNotLoggedIn(state.isOnline, null));
  }

  Future<ConnectionStatus> _setConnectionListener() async {
    final connectionStatus = await _connectivityListener.initConnectivity();
    if (connectionStatus == ConnectionStatus.disconnected)
      emit(state.copyWith(isOnline: false));
    else
      emit(state.copyWith(isOnline: true));
    _connectivitySubscription = _connectivityListener.stream.listen((event) {
      if (event == ConnectionStatus.disconnected)
        emit(state.copyWith(isOnline: false));
      else
        emit(state.copyWith(isOnline: true));
    });
    return connectionStatus;
  }

  bool _usernameValidation(String username) =>
      (username.trim().length <= _settings.maxUsernameLength);
}
