import 'package:deep_rooted_task/screens/currency_pair/presentation/blocs/currency_pair/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrencyPairEvent extends Equatable {
  CurrencyPairEvent([List props = const <dynamic>[]]) : super(props);
  Stream<CurrencyPairState> applyAsync(
      {CurrencyPairState currentState, CurrencyBloc bloc});
}

class SearchTickerEvent extends CurrencyPairEvent {
  final String search;
  SearchTickerEvent(this.search);

  @override
  Stream<CurrencyPairState> applyAsync(
      {CurrencyPairState currentState, CurrencyBloc bloc}) async* {
    bloc.config = search;
    final result = await bloc.fetchCurrencyPair.call(search);
    yield* result.fold((failure) async* {
      yield ErrorState(message: "No Record Found");
    }, (success) async* {
      yield TickerSearchedState(currency: success, name: search.toUpperCase());
    });
  }
}

class ViewOrderBookEvent extends CurrencyPairEvent {
  ViewOrderBookEvent();

  @override
  Stream<CurrencyPairState> applyAsync(
      {CurrencyPairState currentState, CurrencyBloc bloc}) async* {
    final result = await bloc.fetchOrderBook.call(bloc.config.toString());
    yield* result.fold((failure) async* {
      yield ErrorState(message: "No Record Found");
    }, (success) async* {
      yield OrderBookLoadedState(orderbooks: success);
    });
  }
}
