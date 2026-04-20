import 'package:equatable/equatable.dart';

class TargetLocationEntity extends Equatable {
  final String? id;
  final double? targetLat;
  final double? targetLng;

  const TargetLocationEntity({this.id, this.targetLat, this.targetLng});

  @override
  List<Object?> get props => [id, targetLat, targetLng];
}