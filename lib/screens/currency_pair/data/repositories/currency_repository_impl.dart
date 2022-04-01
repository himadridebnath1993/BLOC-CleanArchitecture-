import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/datasources/currency_local_datasource.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/exceptions.dart';
import 'package:deep_rooted_task/core/error/failures.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource localDataSource;

  CurrencyRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, List<String>>> getCurrecyPairs(String search) async {
    try {
      final localData = await localDataSource.getCurrencyPairs(search);
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
