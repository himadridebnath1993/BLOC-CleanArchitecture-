import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/order_book.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrencyPairState extends Equatable {
  CurrencyPairState([List props = const <dynamic>[]]) : super(props);
}

class LoadingState extends CurrencyPairState {}

class InitialCurrencyState extends CurrencyPairState {}

class TickerSearchedState extends CurrencyPairState {
  final Currency currency;
  final String name;
  TickerSearchedState({@required this.currency, @required this.name})
      : super([currency]);
}

class OrderBookLoadedState extends CurrencyPairState {
  final List<OrderBook> orderbooks;
  OrderBookLoadedState({@required this.orderbooks}) : super([orderbooks]);
}

class ErrorState extends CurrencyPairState {
  final String message;
  ErrorState({@required this.message}) : super([message]);
}
