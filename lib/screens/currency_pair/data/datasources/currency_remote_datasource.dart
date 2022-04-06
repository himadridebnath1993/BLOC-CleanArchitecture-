import 'dart:convert';

import 'package:deep_rooted_task/core/error/exceptions.dart';
import 'package:deep_rooted_task/core/network/rest_client_service.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/models/currency_model.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/order_book.dart';
import 'package:flutter/cupertino.dart';

abstract class CurrencyRemoteDataSource {
  Future<Currency> tickerData(String ticker);
  Future<List<OrderBook>> getOrderData(String ticker);
}

class CurrencyRemoteDataSourceImpl extends CurrencyRemoteDataSource {
  final RestClientService restClientService;

  CurrencyRemoteDataSourceImpl({@required this.restClientService});

  @override
  Future<Currency> tickerData(String ticker) async {
    final response = await restClientService.tickerData(ticker);
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return CurrencyModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<OrderBook>> getOrderData(String ticker) async {
    final response = await restClientService.getOrderBook(ticker);
    if (response.statusCode != 200) {
      throw ServerException();
    }

    Map _map = json.decode(response.body);
    List bids = _map['bids'];
    List asks = _map['asks'];
    int _min = (bids.length < asks.length) ? bids.length : asks.length;

    List<OrderBook> _list = [];
    for (int i = 0; i < (_min < 5 ? _min : 5); i++) {
      _list.add(OrderBook(
          bid: bids[i][0], qty: bids[i][1], qty2: asks[i][1], ask: asks[i][0]));
    }
    return _list;
  }
}
