import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import '../../../config/remote_config.dart';
import '../../models/message_model/message_model.dart';
import '../../models/result_model/result_model.dart';
import '../../models/room_model/room_model.dart';
import '../../models/sender_model/sender_model.dart';
import '../../models/settings_model/settings_model.dart';
import '../models_converter.dart';

part 'nane_api_service.chopper.dart';

@ChopperApi()
@injectable
@lazySingleton
abstract class NaneApiService extends ChopperService {
  @Get(path: RemoteConfig.settingsEP)
  Future<Response<ResultModelSettings>> fetchSettings();

  @Get(path: RemoteConfig.roomsEP)
  Future<Response<ResultModelRooms>> fetchRooms();

  @Get(path: '${RemoteConfig.roomsEP}/{name}/history')
  Future<Response<ResultModelHistory>> fetchHistory(@Path('name') String name);

  @factoryMethod
  static NaneApiService create() => 
      _$NaneApiService(ChopperClient(
        baseUrl: RemoteConfig.rootHttpsUrl,
        services: [_$NaneApiService()],
        converter: ModelsConverter(
          {
            MessageModel: (json) => MessageModel.fromJson(json),
            ResultModelHistory: (json) => ResultModelHistory.fromJson(json),
            ResultModelRooms: (json) => ResultModelRooms.fromJson(json),
            ResultModelSettings: (json) => ResultModelSettings.fromJson(json),
            RoomModel: (json) => RoomModel.fromJson(json),
            SenderModel: (json) => SenderModel.fromJson(json),
            SettingsModel: (json) => SettingsModel.fromJson(json),
          }
        ),
      )
    );
}
