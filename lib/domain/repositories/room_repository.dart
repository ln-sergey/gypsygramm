import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../config/remote_config.dart';
import '../../data/local/local_storage_controller.dart';
import '../../data/models/message_model/message_model.dart';
import '../../data/remote/nane_api_service/nane_api_service.dart';
import '../../data/remote/web_socket_controller.dart';
import '../entities/message/message.dart';
import '../entities/room/room.dart';

abstract class RoomRepository {
  Future<void> setDataStreamListener(String roomName);
  Future<Stream<List<Message>>> getMessagesStream(String roomName);
  Future<List<Message>> loadMessagesFromApi(String roomName);
  Future<List<Message>> loadMessagesFromStorage(String roomName);
  Future<void> closeSubscription();
  void closeLocalStorage(String roomName);
  void sendMessage(String roomName, String text);
}

@Injectable(as: RoomRepository)
class RoomRepositoryImpl implements RoomRepository {
  final NaneApiService _apiService;
  final WebSocketController _webSocketController;
  final LocalStorageController _localStorageController;
  final _boxKeyRooms = 'rooms';

  StreamSubscription<dynamic> _webSocketSubscribtion;

  RoomRepositoryImpl(this._webSocketController, this._localStorageController,
      this._apiService);

  @override
  Future<void> setDataStreamListener(String roomName) async {
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
      (await _localStorageController.openBox(_boxKeyRooms))
          .put(message.room, Room(message.room, message));
      if (message.room == roomName)
        (await _localStorageController.openBox(message.room)).put(
            message.created,
            Message(message.room, message.text, message.id, message.created,
                message.sender));
    });
  }

  @override
  Future<List<Message>> loadMessagesFromApi(String roomName) async {
    try {
      final history = (await _apiService.fetchHistory(roomName)).body.result;
      final box = await _localStorageController.openBox(roomName);
      box.putAll(Map.fromIterable(
        history,
        key: (e) => e.created,
        value: (e) => e,
      ));
      return history;
    } catch (e) {
      return <Message>[];
    }
  }

  @override
  Future<Stream<List<Message>>> getMessagesStream(String roomName) async {
    final box = await _localStorageController.openBox(roomName);
    return box.watch().map((event) {
      var listMessages = <Message>[];
      _localStorageController.box(roomName).toMap().forEach((key, value) {
        listMessages.add(value);
      });
      return listMessages;
    });
  }

  @override
  Future<List<Message>> loadMessagesFromStorage(String roomName) async {
    final listMessages = <Message>[];
    (await _localStorageController.openBox(roomName))
        .toMap()
        .forEach((key, value) {
      listMessages.add(value);
    });
    return listMessages;
  }

  @override
  void closeLocalStorage(String roomName) {
    try {
      _localStorageController.box(roomName).close();
    } on HiveError {
      return;
    }
  }

  @override
  void sendMessage(String roomName, String text) {
    _webSocketController.sink
        .add(json.encode({'room': roomName, 'text': text}));
  }

  @override
  Future<void> closeSubscription() async {
    await _webSocketSubscribtion.cancel();
  }
}
