import 'dart:convert';

import 'package:deep_rooted_task/core/error/exceptions.dart';
import 'package:deep_rooted_task/core/utils/constants.dart';

abstract class CurrencyLocalDataSource {
  Future<List<String>> getCurrencyPairs(String search);
}

class CurrencyLocalDataSourceImpl extends CurrencyLocalDataSource {

  List<String> list=['btcusd', 'btceur', 'btcgbp', 'btcpax', 'btcusdc', 'gbpusd',
  'gbpeur', 'eurusd','xrpusd', 'xrpeur', 'xrpbtc', 'xrpgbp', 'xrppax', 'ltcusd', 
  'ltceur', 'ltcbtc', 'ltcgbp', 'ethusd', 'etheur', 'ethbtc', 'ethgbp','ethpax', 
  'ethusdc', 'bchusd', 'bcheur', 'bchbtc', 'bchgbp', 'paxusd', 'paxeur', 'paxgbp', 
  'xlmbtc', 'xlmusd', 'xlmeur','xlmgbp', 'linkusd', 'linkeur', 'linkgbp', 'linkbtc', 
  'linketh', 'omgusd', 'omgeur', 'omggbp', 'omgbtc', 'usdcusd', 'usdceur'];

  @override
  Future<List<String>> getCurrencyPairs(String search) {
    return Future.value(list);
  }
}
