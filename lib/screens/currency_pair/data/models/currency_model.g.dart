// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) {
  return CurrencyModel(
    high: json['high'] as String,
    last: json['last'] as String,
    timestamp: json['timestamp'] as String,
    bid: json['bid'] as String,
    vwap: json['vwap'] as String,
    volume: json['volume'] as String,
    low: json['low'] as String,
    ask: json['ask'] as String,
    open: json['open'] as String,
  );
}

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'high': instance.high,
      'last': instance.last,
      'timestamp': instance.timestamp,
      'bid': instance.bid,
      'vwap': instance.vwap,
      'volume': instance.volume,
      'low': instance.low,
      'ask': instance.ask,
      'open': instance.open,
    };
