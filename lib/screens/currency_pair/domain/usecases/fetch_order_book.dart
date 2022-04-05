import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/order_book.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/core/usecases/usecase.dart';

class FetchOrderBook implements UseCase<List<OrderBook>, String> {
  final CurrencyRepository repository;

  FetchOrderBook({@required this.repository});

  @override
  Future<Either<Failure, List<OrderBook>>> call(String search) async {
    return await repository.getOrderData(search);
  }
}


