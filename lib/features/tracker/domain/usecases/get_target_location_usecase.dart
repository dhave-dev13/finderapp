

import 'package:dartz/dartz.dart';
import 'package:finderapp/core/error/failure.dart';
import 'package:finderapp/core/usecase.dart';
import 'package:finderapp/features/tracker/data/models/target_location_model.dart';
import 'package:finderapp/features/tracker/domain/repositories/geo_locator_repository.dart';

class GetTargetLocationUsecase implements UseCaseWithNoParams<TargetLocationModel> {
  final GeoLocatorRepository repository;
  GetTargetLocationUsecase(this.repository);

  @override
  Future<Either<Failure, TargetLocationModel>> call() async {
    return await repository.getTargetLocations();
  }
}
