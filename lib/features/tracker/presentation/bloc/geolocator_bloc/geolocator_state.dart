part of 'geolocator_bloc.dart';

sealed class GeolocatorState extends Equatable {
  const GeolocatorState();
  
  @override
  List<Object> get props => [];
}

final class GeolocatorInitial extends GeolocatorState {}
