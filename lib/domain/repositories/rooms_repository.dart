import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../config/remote_config.dart';
import '../../data/local/local_storage_controller.dart';
import '../../data/models/message_model/message_model.dart';
import '../../data/remote/nane_api_service/nane_api_service.dart';
import '../../data/remote/web_socket_controller.dart';
import '../entities/message/message.dart';
import '../entities/room/room.dart';

abstract class RoomsRepository {
  Future<void> setDataStreamListener();
  Future<Stream<List<Room>>> getRoomsStream();
  Future<List<Room>> loadRoomsFromApi();
  Future<List<Room>> loadRoomsFromStorage();
  Future<void> closeSubscription();
  void closeDataStream();
  void closeLocalStorage();
}

@Injectable(as: RoomsRepository)
class RoomsRepositoryImpl implements RoomsRepository {
  final NaneApiService _apiService;
  final WebSocketController _webSocketController;
  final LocalStorageController _localStorageController;
  final _boxKey = 'rooms';

  StreamSubscription<dynamic> _webSocketSubscribtion;

  RoomsRepositoryImpl(this._webSocketController, this._localStorageController,
      this._apiService);

  @override
  Future<void> setDataStreamListener() async {
    Stream<dynamic> dataStream;
    try {
      dataStream = _webSocketController.stream;
    } on NoSuchMethodError {
      final username =
          (await _localStorageController.openBox('authentification'))
              .get('user');
      dataStream = _webSocketController
          .connect('${RemoteConfig.rootWSUrl}?username=$username');
    }
    _webSocketSubscribtion = dataStream.listen((event) async {
      final message = MessageModel.fromJson(json.decode(event));
      final box = await _localStorageController.openBox(_boxKey);
      box.put(message.room, Room(message.room, message));
    });
  }

  @override
  Future<List<Room>> loadRoomsFromApi() async {
    final rooms = (await _apiService.fetchRooms()).body.result;
    final box = await _localStorageController.openBox(_boxKey);
    box.putAll(Map.fromIterable(
      rooms,
      key: (e) => e.name,
      value: (e) => Room(
          e.name,
          Message(e.name, e.lastMessage.text, e.lastMessage.id,
              e.lastMessage.created, e.lastMessage.sender)),
    ));
    return rooms;
  }

  @override
  Future<Stream<List<Room>>> getRoomsStream() async {
    final box = await _localStorageController.openBox(_boxKey);
    return box.watch().map((event) {
      var listRooms = <Room>[];
      _localStorageController.box(_boxKey).toMap().forEach((key, value) {
        listRooms.add(value);
      });
      return listRooms;
    });
  }

  @override
  Future<List<Room>> loadRoomsFromStorage() async {
    final listRooms = <Room>[];
    (await _localStorageController.openBox(_boxKey))
        .toMap()
        .forEach((key, value) {
      listRooms.add(value);
    });
    return listRooms;
  }

  @override
  Future<void> closeSubscription() async {
    await _webSocketSubscribtion.cancel();
  }

  @override
  void closeDataStream() {
    _apiService.dispose();
    _webSocketController.close();
  }

  @override
  void closeLocalStorage() {
    _localStorageController.close();
  }
}
