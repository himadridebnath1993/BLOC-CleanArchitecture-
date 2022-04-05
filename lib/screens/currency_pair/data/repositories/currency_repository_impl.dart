import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/core/network/network_info.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/datasources/currency_local_datasource.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/datasources/currency_remote_datasource.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/currency.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/entities/order_book.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_rooted_task/core/error/exceptions.dart';
import 'package:deep_rooted_task/core/error/failures.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource localDataSource;
  final CurrencyRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  CurrencyRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<String>>> getCurrecyList(String search) async {
    try {
      final localData = await localDataSource.getCurrencyPairs(search);
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Currency>> tickerData(String search) async {
    if (await networkInfo.isConnected) {
      try {
        final localData = await remoteDataSource.tickerData(search);
        return Right(localData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  
  @override
  Future<Either<Failure, List<OrderBook>>> getOrderData(String search) async{
     if (await networkInfo.isConnected) {
      try {
        final localData = await remoteDataSource.getOrderData(search);
        return Right(localData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
