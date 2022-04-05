import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/core/usecases/usecase.dart';

class FetchCurrencyTicker implements UseCase<Currency, String> {
  final CurrencyRepository repository;

  FetchCurrencyTicker({@required this.repository});

  @override
  Future<Either<Failure, Currency>> call(String search) async {
    return await repository.tickerData(search);
  }
}


