import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/failures.dart';
import 'package:deep_rooted_task/core/usecases/usecase.dart';

class CurrencyPair implements UseCase<List<String>, CurrencyParams> {
  final CurrencyRepository repository;

  CurrencyPair({@required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(CurrencyParams params) async {
    return await repository.getCurrecyPairs(params.search);
  }
}

class CurrencyParams extends Equatable {
  final String search;

  CurrencyParams({@required this.search})
      : super([search]);
}
