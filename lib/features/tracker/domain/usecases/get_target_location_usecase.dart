

import 'package:dartz/dartz.dart';
import 'package:finderapp/core/error/failure.dart';
import 'package:finderapp/core/usecase.dart';
import 'package:finderapp/features/tracker/domain/entities/target_location_entity.dart';
import 'package:finderapp/features/tracker/domain/repositories/geo_locator_repository.dart';

class GetTargetLocationUsecase implements UseCaseWithNoParams<TargetLocationEntity> {
  final GeoLocatorRepository repository;
  GetTargetLocationUsecase(this.repository);

  @override
  Future<Either<Failure, TargetLocationEntity>> call() async {
    return await repository.getTargetLocations();
  }
}
