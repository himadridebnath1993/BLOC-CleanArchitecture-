import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/usecases/fetch_currency_ticker.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/usecases/fetch_order_book.dart';
import 'package:flutter/cupertino.dart';

import 'bloc.dart';

class CurrencyBloc extends Bloc<CurrencyPairEvent, CurrencyPairState> {
  final FetchCurrencyTicker fetchCurrencyPair;
  final FetchOrderBook fetchOrderBook;
  dynamic _config;

  CurrencyBloc({@required this.fetchCurrencyPair,@required this.fetchOrderBook})
      : super(InitialCurrencyState());

  dynamic get config => _config;

  set config(dynamic c) {
    _config = c;
  }

  @override
  Stream<CurrencyPairState> mapEventToState(
    CurrencyPairEvent event,
  ) async* {
    yield LoadingState();
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (e, stackTrace) {
      yield ErrorState(message: e?.toString());
    }
  }
}
