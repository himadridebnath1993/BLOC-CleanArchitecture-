import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrencyPairEvent extends Equatable {
  CurrencyPairEvent([List props = const <dynamic>[]]) : super(props);
}


class SearchEvent extends CurrencyPairEvent {
  final String search;
  SearchEvent(this.search);
}

