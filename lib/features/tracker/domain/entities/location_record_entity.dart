// domain/entities/location_record_entity.dart
import 'package:equatable/equatable.dart';

class LocationRecordEntity extends Equatable {
  final String id;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final double distance; // in meters
  final String formattedDistance;
  final String targetId;

  const LocationRecordEntity({
    required this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.formattedDistance,
    required this.targetId,
  });

  @override
  List<Object?> get props => [id, timestamp, latitude, longitude, distance, targetId];
}