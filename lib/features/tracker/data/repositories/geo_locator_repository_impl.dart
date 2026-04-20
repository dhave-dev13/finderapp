import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finderapp/core/error/failure.dart';
import 'package:finderapp/features/tracker/data/datasources/remote/geo_location_data_source.dart';
import 'package:finderapp/features/tracker/data/datasources/services/geo_location_service.dart';
import 'package:finderapp/features/tracker/domain/entities/target_location_entity.dart';
import 'package:finderapp/features/tracker/domain/repositories/geo_locator_repository.dart';
import 'package:get_it/get_it.dart';

class GeoLocatorRepositoryImpl implements GeoLocatorRepository {
  final GeoLocationDataSource remoteDataSource;
  final apiService = GetIt.instance<GeoLocationService>();

  GeoLocatorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TargetLocationEntity>> getTargetLocations() async {
     try {
      final response = await remoteDataSource.getTargetLocations();
      return Right(response.data!.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }    
    catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}