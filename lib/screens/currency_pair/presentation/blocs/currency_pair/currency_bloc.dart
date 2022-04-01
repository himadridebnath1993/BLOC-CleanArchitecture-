import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/usecases/fetch_currency_pair.dart';

import 'bloc.dart';

class CurrencyBloc extends Bloc<CurrencyPairEvent, CurrencyPairState> {
  final FetchCurrencyPair fetchCurrencyPair;

  CurrencyBloc({@required this.fetchCurrencyPair});

  @override
  CurrencyPairState get initialState => InitialCurrencyState();

  @override
  Stream<CurrencyPairState> mapEventToState(CurrencyPairEvent event) async* {
    if (event is SearchEvent) {
      yield LoadingState();
      final result = await fetchCurrencyPair.call(event.search);
      yield* result.fold((failure) async* {
        yield ErrorState(message: "No Record Found");
      }, (success) async* {
        yield SearchedState(list: success);
      });
    }
  }
}
