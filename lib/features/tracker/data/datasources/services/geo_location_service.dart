

import 'package:dio/dio.dart';
import 'package:finderapp/features/tracker/data/models/target_location_model.dart';
import 'package:retrofit/retrofit.dart';

part 'geo_location_service.g.dart';

@RestApi()

abstract class GeoLocationService {
  factory GeoLocationService(Dio dio, {String baseUrl}) = _GeoLocationService;

  @GET("/target-location")
  Future<TargetLocationModel> getTargetLocations();


}