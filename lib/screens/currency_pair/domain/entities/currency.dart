
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Currency extends Equatable {
  final String high;
  final String last;
  final String timestamp;
  final String bid;
  final String vwap;
  final String volume;
  final String low;
  final String ask;
  final String open;
  Currency(
      {@required this.high,
      @required this.last,
      @required this.timestamp,
      @required this.bid,
      @required this.vwap,
      @required this.volume,
      @required this.low,
      @required this.ask,
      @required this.open})
      : super([high, last, timestamp, bid, vwap, volume, low, ask, open]);
}
