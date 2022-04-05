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
    

    return [];
  }
}
