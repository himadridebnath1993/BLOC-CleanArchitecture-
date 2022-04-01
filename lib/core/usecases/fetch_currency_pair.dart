import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/core/usecases/usecase.dart';

class FetchCurrencyPair implements UseCase<List<String>, String> {
  final CurrencyRepository repository;

  FetchCurrencyPair({@required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(String search) async {
    return await repository.getCurrecyPairs(search);
  }
}


