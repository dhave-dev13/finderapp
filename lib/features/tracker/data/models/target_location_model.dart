import 'package:equatable/equatable.dart';
import 'package:finderapp/features/tracker/domain/entities/target_location_entity.dart';

class TargetLocationModel extends Equatable {
  final TargetLocationDataModel? data;
  const TargetLocationModel({
    this.data,
  });

  @override
  List<Object?> get props => [data];

  TargetLocationModel copyWith({
    TargetLocationDataModel? data,
  }) {
    return TargetLocationModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data?.toJson(),
    };
  }

  factory TargetLocationModel.fromJson(Map<String, dynamic> json) => TargetLocationModel(
      data: json['data'] != null ? TargetLocationDataModel.fromJson(json['data'] as Map<String,dynamic>) : null,
    );

  @override
  bool get stringify => true;
}



class TargetLocationDataModel extends Equatable {
  final String? id;
  final double? targetLat;
  final double? targetLng;
  const TargetLocationDataModel({
    this.id,
    this.targetLat,
    this.targetLng,
  });

  @override
  List<Object?> get props => [id, targetLat, targetLng];

  TargetLocationDataModel copyWith({
    String? id,
    double? targetLat,
    double? targetLng,
  }) {
    return TargetLocationDataModel(
      id: id ?? this.id,
      targetLat: targetLat ?? this.targetLat,
      targetLng: targetLng ?? this.targetLng,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'target_lat': targetLat,
    'target_lng': targetLng,
  };

  factory TargetLocationDataModel.fromJson(Map<String, dynamic> json) => TargetLocationDataModel(
    id: json['id'] as String?,
    targetLat: json['target_lat'] as double?,
    targetLng: json['target_lng'] as double?
  );

  factory TargetLocationDataModel.fromEntity(TargetLocationEntity entity) {
    return TargetLocationDataModel(
      id: entity.id,
      targetLat: entity.targetLat,
      targetLng: entity.targetLng
    );
  }

  TargetLocationEntity toEntity() {
    return TargetLocationEntity(
      id: id,
      targetLat: targetLat,
      targetLng: targetLng
    );
  }
  

  @override
  bool get stringify => true;
}
