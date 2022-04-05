import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderBook extends Equatable {
  final String bid;
  final String qty;
  final String qty2;
  final String ask;
  OrderBook(
      {@required this.bid,
      @required this.qty,
      @required this.qty2,
      @required this.ask})
      : super([bid, qty, qty2, ask]);
}
