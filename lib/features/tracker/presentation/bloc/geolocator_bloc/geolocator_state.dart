// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'geolocator_bloc.dart';

class GeolocatorState extends Equatable {
  final GeolocatorStatus status;
  final List<Position> locationHistory;
  final Position? currentLocation;
  final String? errorMessage;
  final int tickCount;

  const GeolocatorState({
    this.status = GeolocatorStatus.idle,
    this.locationHistory = const [],
    this.currentLocation,
    this.errorMessage,
    this.tickCount = 0,
  });

  @override
  List<Object?> get props => [status, locationHistory, currentLocation, errorMessage, tickCount];



  GeolocatorState copyWith({
    GeolocatorStatus? status,
    List<Position>? locationHistory,
    Position? currentLocation,
    String? errorMessage,
    int? tickCount,
  }) {
    return GeolocatorState(
      status: status ?? this.status,
      locationHistory: locationHistory ?? this.locationHistory,
      currentLocation: currentLocation ?? this.currentLocation,
      errorMessage: errorMessage ?? this.errorMessage,
      tickCount: tickCount ?? this.tickCount,
    );
  }
}
