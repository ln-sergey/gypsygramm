import 'dart:async';

import 'package:gypsygramm/data/errors/exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class WebSocketController {
  Stream<dynamic> connect(String url);
  Stream<dynamic> get stream;
  WebSocketSink get sink;
  void add(dynamic obj);
  Future<void> close();
}

@Injectable(as: WebSocketController)
@lazySingleton
class WebSocketControllerImpl implements WebSocketController {
  IOWebSocketChannel _channel;
  StreamController<dynamic> _streamController;

  @override
  Stream connect(String url) {
    try {
      _channel = IOWebSocketChannel.connect(Uri.encodeFull(url));
      _streamController = StreamController.broadcast();
      _streamController.addStream(_channel.stream);
      return _streamController.stream;
    } on WebSocketChannelException {
      throw ServerException();
    }
  }

  @override
  Stream get stream => _streamController.stream;

  @override
  WebSocketSink get sink => _channel.sink;

  @override
  void add(dynamic obj) => _channel.sink.add(obj);

  @override
  Future<void> close() async {
    try {
      if (_channel.closeCode == null) await _channel.sink.close();
      await _streamController.sink.close();
      await _streamController.close();
    } catch (e) {
      return;
    }
  }
}
