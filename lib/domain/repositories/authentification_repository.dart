import 'package:injectable/injectable.dart';

import '../../config/remote_config.dart';
import '../../data/errors/exceptions.dart';
import '../../data/local/local_storage_controller.dart';
import '../../data/remote/nane_api_service/nane_api_service.dart';
import '../../data/remote/web_socket_controller.dart';
import '../entities/settings/settings.dart';

abstract class AuthentificationRepository {
  Future<Stream<dynamic>> getDataStream({username});
  Future closeDataStream();
  Future signOutUser();
  Future<Settings> getSettings();
  Future<String> getUsername();
}

@Injectable(as: AuthentificationRepository)
class AuthentificationRepositoryImpl implements AuthentificationRepository {
  final NaneApiService _apiService;
  final WebSocketController _webSocketController;
  final LocalStorageController _localStorageController;
  final _boxKey = 'authentification';
  final _userKey = 'user';

  AuthentificationRepositoryImpl(this._webSocketController,
      this._localStorageController, this._apiService);

  @override
  Future<Stream<dynamic>> getDataStream({username}) async {
    var name = username;
    if (name == null) {
      name = await getUsername();
    }
    if (name == null) throw CacheException();
    Stream dataStream;
    try {
      dataStream = _webSocketController.stream;
    } on NoSuchMethodError {
      dataStream = _webSocketController
          .connect('${RemoteConfig.rootWSUrl}?username=$name');
    }
    (await _localStorageController.openBox(_boxKey)).put(_userKey, name);
    return dataStream;
  }

  @override
  Future closeDataStream() => _webSocketController.close();

  @override
  Future signOutUser() async {
    await closeDataStream();
    await _localStorageController.deleteAll();
  }

  @override
  Future<Settings> getSettings() async =>
      (await _apiService.fetchSettings()).body.result;

  @override
  Future<String> getUsername() async =>
      (await _localStorageController.openBox(_boxKey)).get(_userKey);
}
