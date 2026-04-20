// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'geolocator_bloc.dart';

class GeolocatorState extends Equatable {
  final GeolocatorStatus status;
  final List<LocationRecordEntity> records;
  final LocationRecordEntity? targetLocation;
  final int? filterLimit;
  final int? totalRecords;
  final String? errorMessage;
  final int tickCount;
  final bool isTargetLocationReady;

  const GeolocatorState({
    this.status = GeolocatorStatus.idle,
    this.records = const [],
    this.targetLocation,
    this.filterLimit = 10,
    this.errorMessage,
    this.totalRecords = 0,
    this.tickCount = 0,
    this.isTargetLocationReady = false
  });

  @override
  List<Object?> get props => [status, records, targetLocation, filterLimit, totalRecords, errorMessage, tickCount, isTargetLocationReady];

  GeolocatorState copyWith({
    GeolocatorStatus? status,
    List<LocationRecordEntity>? records,
    LocationRecordEntity? targetLocation,
    int? filterLimit,
    int? totalRecords,
    String? errorMessage,
    int? tickCount,
    bool? isTargetLocationReady,
  }) {
    return GeolocatorState(
      status: status ?? this.status,
      records: records ?? this.records,
      targetLocation: targetLocation ?? this.targetLocation,
      filterLimit: filterLimit ?? this.filterLimit,
      totalRecords: totalRecords ?? this.totalRecords,
      errorMessage: errorMessage ?? this.errorMessage,
      tickCount: tickCount ?? this.tickCount,
      isTargetLocationReady: isTargetLocationReady ?? this.isTargetLocationReady,
    );
  }

  // Helper to get filtered records based on limit
  List<LocationRecordEntity> get filteredRecords {
    if ((filterLimit ?? 0) >= records.length) return records;
    return records.take(filterLimit ?? 0).toList();
  }
}
