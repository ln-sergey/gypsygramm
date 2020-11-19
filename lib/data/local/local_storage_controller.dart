import 'package:gypsygramm/domain/entities/message/message.dart';
import 'package:gypsygramm/domain/entities/result/result.dart';
import 'package:gypsygramm/domain/entities/room/room.dart';
import 'package:gypsygramm/domain/entities/sender/sender.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class LocalStorageController {
  Future init();
  Future<Box<E>> openBox<E>(String name);
  Box<E> box<E>(String name);
  Future<void> close();
  Future<void> deleteAll();
}

@Injectable(as: LocalStorageController)
@lazySingleton
class LocalStorageControllerImpl implements LocalStorageController {
  @override
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ResultHistoryAdapter());
    Hive.registerAdapter(ResultRoomsAdapter());
    Hive.registerAdapter(ResultSettingsAdapter());
    Hive.registerAdapter(RoomAdapter());
    Hive.registerAdapter(SenderAdapter());
  }

  @override
  Future<Box<E>> openBox<E>(String name) => Hive.openBox(name);

  @override
  Box<E> box<E>(String name) => Hive.box(name);

  @override
  Future<void> close() => Hive.close();

  @override
  Future<void> deleteAll() => Hive.deleteFromDisk();
}
