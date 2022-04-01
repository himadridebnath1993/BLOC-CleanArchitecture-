import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:deep_rooted_task/core/utils/constants.dart';

part "rest_client_service.chopper.dart";

@ChopperApi(baseUrl: API_BASE_URL)
abstract class RestClientService extends ChopperService {
  static RestClientService create([ChopperClient client]) =>
      _$RestClientService(client);

  @Get(path: TICKER+'{title}')
  Future<Response> tickerData(@Path('title') final String title);

  @Get(path: ORDER_BOOK+'{title}')
  Future<Response> getOrderBook(@Path('title') final String title);
}
