import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/order_book.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<String>>> getCurrecyList(String search);
  Future<Either<Failure, Currency>> tickerData(String search);
  Future<Either<Failure, List<OrderBook>>> getOrderData(String search);
}
