import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/core/usecases/usecase.dart';

class FetchCurrencyList implements UseCase<List<String>, String> {
  final CurrencyRepository repository;

  FetchCurrencyList({@required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(String params) async {
    return await repository.getCurrecyList(params);
  }
}
