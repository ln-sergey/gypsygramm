import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

enum ConnectionStatus { connected, disconnected }

abstract class ConnectivityListener {
  /// Connection conditions stream
  ///
  /// provides entities of [ConnectionStatus] enum
  Stream<ConnectionStatus> get stream;

  Future<ConnectionStatus> initConnectivity();
}

@Injectable(as: ConnectivityListener)
@lazySingleton
class ConnectivityListenerImpl implements ConnectivityListener {
  final Connectivity _connectivity;

  ConnectivityListenerImpl(this._connectivity);

  Future<ConnectionStatus> initConnectivity() async {
    var result = ConnectionStatus.disconnected;
    try {
      result =
          (await _connectivity.checkConnectivity() == ConnectivityResult.none)
              ? ConnectionStatus.disconnected
              : ConnectionStatus.connected;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  @override
  Stream<ConnectionStatus> get stream =>
      _connectivity.onConnectivityChanged.distinct((event1, event2) {
        final temp = ({event1, event2})
            .containsAll({ConnectivityResult.mobile, ConnectivityResult.wifi});
        return (event1 == event2) || temp;
      }).map((event) => event == ConnectivityResult.none
          ? ConnectionStatus.disconnected
          : ConnectionStatus.connected);
}
