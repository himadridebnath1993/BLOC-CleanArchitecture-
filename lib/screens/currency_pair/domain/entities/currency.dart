import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Currency extends Equatable {
  final List pairs;
  Currency({@required this.pairs}) : super([pairs]);
}
