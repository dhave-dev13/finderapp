import 'package:dartz/dartz.dart';
import 'package:finderapp/core/error/failure.dart';
import 'package:finderapp/features/tracker/data/models/target_location_model.dart';

abstract class GeoLocatorRepository {
  Future<Either<Failure, TargetLocationModel>> getTargetLocations();
}