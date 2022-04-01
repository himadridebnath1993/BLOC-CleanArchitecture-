import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel extends Currency {
  CurrencyModel({@required List pairs}) : super(pairs: pairs);
}
