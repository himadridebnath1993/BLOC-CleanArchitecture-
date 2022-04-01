// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$RestClientService extends RestClientService {
  _$RestClientService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RestClientService;

  @override
  Future<Response<dynamic>> tickerData(String title) {
    final $url = 'https://www.bitstamp.net/api/v2/ticker/$title';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrderBook(String title) {
    final $url = 'https://www.bitstamp.net/api/v2/order_book/$title';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
