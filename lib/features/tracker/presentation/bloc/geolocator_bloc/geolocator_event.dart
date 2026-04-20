part of 'geolocator_bloc.dart';

abstract class GeolocatorEvent extends Equatable {
  const GeolocatorEvent();

  @override
  List<Object?> get props => [];
}

class StartLocationTracking extends GeolocatorEvent {
  final Duration interval;
  const StartLocationTracking({this.interval = const Duration(seconds: 5)});
  
  @override
  List<Object?> get props => [interval];
}

class ToggleTracking extends GeolocatorEvent {}

class StopLocationTracking extends GeolocatorEvent {}

class LocationDataReceived extends GeolocatorEvent {
  final Position position;
  
  const LocationDataReceived(this.position);
  
  @override
  List<Object?> get props => [position];
}

class LoadHistoricalRecords extends GeolocatorEvent {
  final int? limit;
  
  const LoadHistoricalRecords({this.limit});
  
  @override
  List<Object?> get props => [limit];
}

class UpdateFilterLimit extends GeolocatorEvent {
  final int limit;
  
  const UpdateFilterLimit(this.limit);
  
  @override
  List<Object?> get props => [limit];
}

class ClearLocationHistory extends GeolocatorEvent {}