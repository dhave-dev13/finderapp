import 'package:equatable/equatable.dart';
import 'package:finderapp/features/tracker/domain/entities/location_record_entity.dart';

class LocationRecordModel extends Equatable {
  final String id;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final double distance;
  final String formattedDistance;
  final String targetId;

  const LocationRecordModel({
    required this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.formattedDistance,
    required this.targetId
  });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [id, timestamp, latitude, longitude, distance, formattedDistance, targetId];
  }

  LocationRecordModel copyWith({String? id, DateTime? timestamp, double? latitude, double? longitude, double? distance, String? formattedDistance, String? targetId}) {
    return LocationRecordModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distance: distance ?? this.distance,
      formattedDistance: formattedDistance ?? this.formattedDistance,
      targetId: targetId ?? this.targetId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'timestamp': timestamp.millisecondsSinceEpoch,
    'latitude': latitude,
    'longitude': longitude,
    'distance': distance,
    'formattedDistance': formattedDistance,
    'targetId': targetId,
  };

  factory LocationRecordModel.fromJson(Map<String, dynamic> json) => LocationRecordModel(
    id: json['id'] as String,
    timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    latitude: json['latitude'] as double,
    longitude: json['longitude'] as double,
    distance: json['distance'] as double,
    formattedDistance: json['formattedDistance'] as String,
    targetId: json['targetId'] as String,
  );

  factory LocationRecordModel.fromEntity(LocationRecordEntity entity) {
    return LocationRecordModel(
      id: entity.id,
      timestamp: entity.timestamp,
      latitude: entity.latitude,
      longitude: entity.longitude,
      distance: entity.distance,
      formattedDistance: entity.formattedDistance,
      targetId: entity.targetId,
    );
  }

  LocationRecordEntity toEntity() {
    return LocationRecordEntity(
      id: id,
      timestamp: timestamp,
      latitude: latitude,
      longitude: longitude,
      distance: distance,
      formattedDistance: formattedDistance,
      targetId: targetId,
    );
  }

  @override
  bool get stringify => true;
}
