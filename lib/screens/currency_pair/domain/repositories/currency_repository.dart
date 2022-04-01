import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<String>>> getCurrecyPairs(String search);
}
