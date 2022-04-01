import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrencyPairState extends Equatable {
  CurrencyPairState([List props = const <dynamic>[]]) : super(props);
}

class LoadingState extends CurrencyPairState {}
class InitialCurrencyState extends CurrencyPairState {}

class SearchedState extends CurrencyPairState {
  final List<String> list;
  SearchedState({@required this.list}) : super([list]);
}

class ErrorState extends CurrencyPairState {
  final String message;

  ErrorState({@required this.message}) : super([message]);
}
