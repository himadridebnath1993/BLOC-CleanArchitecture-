import 'dart:ffi';

import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel extends Currency {
  CurrencyModel(
      {@required String high,
      @required String last,
      @required String timestamp,
      @required String bid,
      @required String vwap,
      @required String volume,
      @required String low,
      @required String ask,
      @required String open})
      : super(
            high: high,
            last: last,
            timestamp: timestamp,
            bid: bid,
            vwap: vwap,
            volume: volume,
            low: low,
            ask: ask,
            open: open);

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
