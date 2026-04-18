import 'package:equatable/equatable.dart';

class TargetLocationModel extends Equatable {
  final String? id;
  final double? targetLat;
  final double? targetLng;
  const TargetLocationModel({
    this.id,
    this.targetLat,
    this.targetLng,
  });

  @override
  List<Object?> get props => [id, targetLat, targetLng];

  TargetLocationModel copyWith({
    String? id,
    double? targetLat,
    double? targetLng,
  }) {
    return TargetLocationModel(
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

  factory TargetLocationModel.fromJson(Map<String, dynamic> json) => TargetLocationModel(
    id: json['id'] as String?,
    targetLat: json['target_lat'] as double?,
    targetLng: json['target_lng'] as double?
  );

  @override
  bool get stringify => true;
}
