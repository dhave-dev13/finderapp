part of 'geolocator_bloc.dart';

class GeolocatorEvent extends Equatable {
  const GeolocatorEvent();

  @override
  List<Object> get props => [];
}

class GetDeviceLocation extends GeolocatorEvent {}

class StopDeviceLocation extends GeolocatorEvent {}
