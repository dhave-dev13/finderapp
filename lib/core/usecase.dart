import 'package:finderapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class UseCaseWithNoParams<T>{
  Future<Either<Failure, T>> call();
}