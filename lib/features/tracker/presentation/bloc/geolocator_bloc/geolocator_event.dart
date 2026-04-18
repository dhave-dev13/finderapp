part of 'geolocator_bloc.dart';

class GeolocatorEvent extends Equatable {
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

class StopLocationTracking extends GeolocatorEvent {}

class LocationTick extends GeolocatorEvent {
  final Position position;
  const LocationTick(this.position);
  
  @override
  List<Object?> get props => [position];
}
