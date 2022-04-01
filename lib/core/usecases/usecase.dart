import 'package:dartz/dartz.dart';
import 'package:deep_rooted_task/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
