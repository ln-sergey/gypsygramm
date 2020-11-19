// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nane_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NaneApiService extends NaneApiService {
  _$NaneApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NaneApiService;

  @override
  Future<Response<ResultModelSettings>> fetchSettings() {
    final $url = 'https://nane.tada.team/api/settings';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ResultModelSettings, ResultModelSettings>($request);
  }

  @override
  Future<Response<ResultModelRooms>> fetchRooms() {
    final $url = 'https://nane.tada.team/api/rooms';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ResultModelRooms, ResultModelRooms>($request);
  }

  @override
  Future<Response<ResultModelHistory>> fetchHistory(String name) {
    final $url = 'https://nane.tada.team/api/rooms/$name/history';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ResultModelHistory, ResultModelHistory>($request);
  }
}
