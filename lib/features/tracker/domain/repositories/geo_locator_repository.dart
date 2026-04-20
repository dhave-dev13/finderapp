import 'package:dartz/dartz.dart';
import 'package:finderapp/core/error/failure.dart';
import 'package:finderapp/features/tracker/domain/entities/target_location_entity.dart';

abstract class GeoLocatorRepository {
  Future<Either<Failure, TargetLocationEntity>> getTargetLocations();
}