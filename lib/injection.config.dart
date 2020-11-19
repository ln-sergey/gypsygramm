// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'presentation/authentification/cubit/authentification_cubit.dart';
import 'domain/repositories/authentification_repository.dart';
import 'data/remote/connectivity_listener.dart';
import 'injection.dart';
import 'data/local/local_storage_controller.dart';
import 'data/remote/nane_api_service/nane_api_service.dart';
import 'domain/repositories/room_repository.dart';
import 'domain/repositories/rooms_repository.dart';
import 'data/remote/web_socket_controller.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final externalDependencesModule = _$ExternalDependencesModule();
  gh.factory<Connectivity>(() => externalDependencesModule.connectivity);
  gh.factory<ConnectivityListener>(
      () => ConnectivityListenerImpl(get<Connectivity>()));
  gh.factory<LocalStorageController>(() => LocalStorageControllerImpl());
  gh.factory<NaneApiService>(() => NaneApiService.create());
  gh.factory<WebSocketController>(() => WebSocketControllerImpl());
  gh.factory<AuthentificationRepository>(() => AuthentificationRepositoryImpl(
        get<WebSocketController>(),
        get<LocalStorageController>(),
        get<NaneApiService>(),
      ));
  gh.factory<RoomRepository>(() => RoomRepositoryImpl(
        get<WebSocketController>(),
        get<LocalStorageController>(),
        get<NaneApiService>(),
      ));
  gh.factory<RoomsRepository>(() => RoomsRepositoryImpl(
        get<WebSocketController>(),
        get<LocalStorageController>(),
        get<NaneApiService>(),
      ));
  gh.factory<AuthentificationCubit>(() => AuthentificationCubit(
      get<AuthentificationRepository>(), get<ConnectivityListener>()));
  return get;
}

class _$ExternalDependencesModule extends ExternalDependencesModule {}
