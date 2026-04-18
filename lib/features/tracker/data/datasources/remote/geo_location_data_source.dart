import 'package:finderapp/features/tracker/data/datasources/services/geo_location_service.dart';
import 'package:finderapp/features/tracker/data/models/target_location_model.dart';

abstract class GeoLocationDataSource {
  Future<TargetLocationModel> getTargetLocations();
}

class GeoLocationDataSourceImpl implements GeoLocationDataSource {
  final GeoLocationService _locationService;
  GeoLocationDataSourceImpl(GeoLocationService locationService) : _locationService = locationService;
  
  @override
  Future<TargetLocationModel> getTargetLocations() async {
    return await _locationService.getTargetLocations();
  }
}