import 'dart:async';
import 'dart:ui';

import 'package:finderapp/core/services/app_lifecycle_service.dart';
import 'package:finderapp/core/services/hive/global_hive.dart';
import 'package:finderapp/core/services/hive/hive_service.dart';
import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/distance_calculator.dart';
import 'package:finderapp/core/utils/enums.dart';
import 'package:finderapp/features/tracker/data/models/location_record_model.dart';
import 'package:finderapp/features/tracker/domain/entities/location_record_entity.dart';
import 'package:finderapp/features/tracker/domain/entities/target_location_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

part 'geolocator_event.dart';
part 'geolocator_state.dart';

class GeolocatorBloc extends Bloc<GeolocatorEvent, GeolocatorState> {
  /// using stream
  StreamSubscription<Position>? _positionStreamSubscription;
  Timer? _locationTimer;
  Position? _latestPosition;
  TargetLocationEntity? _currentTarget;
  final _uuid = const Uuid();

  /// for generating id when saving locations to storage
  final HiveService _hiveService = GetIt.instance<GlobalHive>().globalHive;

  /// AppLifeCycleService
  final AppLifecycleService _lifecycleService = GetIt.instance<AppLifecycleService>();
  StreamSubscription<AppLifecycleState>? _lifecycleSubscription;

  GeolocatorBloc() : super(GeolocatorState()) {
    on<StartLocationTracking>(_startLocationTracking);
    on<StopLocationTracking>(_stopLocationTracking);
    on<ToggleTracking>(_onToggleTracking);
    on<LocationDataReceived>(_onLocationDataReceived);
    on<LoadHistoricalRecords>(_onLoadHistorialRecords);
    on<UpdateFilterLimit>(_onUpdateFilterLimit);
    on<ClearLocationHistory>(_onClearLocationHistory);

    // Load existing records when bloc is created
    add(const LoadHistoricalRecords());

    // Listen to global app lifecycle stream
    _lifecycleSubscription = _lifecycleService.lifecycleStream.listen((state) {
      _handleAppLifecycleState(state);
    });
  }

    // ==================== LIFECYCLE HANDLER ====================
  
  void _handleAppLifecycleState(AppLifecycleState state) {
    appLogger.d('BLoC received lifecycle state: $state');
    
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // App went to background - PAUSE tracking
      add(StopLocationTracking());
    } else if (state == AppLifecycleState.resumed) {
      // App came to foreground - RESUME tracking
      add(StartLocationTracking());
    }
  }

  @override
  Future<void> close() {
    _lifecycleSubscription?.cancel();
    return super.close();
  }

  /// step 1: toggle switch event for ON and OFF
  FutureOr<void> _onToggleTracking(ToggleTracking event, Emitter<GeolocatorState> emit) {
    appLogger.d('ToggleTracking::: ${state.status}');
    if (state.status == GeolocatorStatus.tracking) {
      ///stopped tracking since status is already tracking
      add(StopLocationTracking());
    } else {
      ///start tracking since status is idle
      add(const StartLocationTracking());

    }
  }

  // Tottle Switch value = tracking
  FutureOr<void> _startLocationTracking(StartLocationTracking event, Emitter<GeolocatorState> emit) async {

    /// check permission first if location sharing is allowed by the user
    final hasPermission = await _checkPermissions();
    if (!hasPermission) {
      emit(state.copyWith(status: GeolocatorStatus.error));
      return;
    }

    emit(state.copyWith(status: GeolocatorStatus.tracking));

    // Listen to continuous location updates
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0, // Get all updates regardless of distance
      timeLimit: Duration(seconds: 1),
    );

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      _latestPosition = position;
    });

    

    // Sample every 5 seconds
    _locationTimer = Timer.periodic(event.interval, (timer) async {
      if (_latestPosition != null) {
          add(LocationDataReceived(_latestPosition!));
          appLogger.i('Device Position:: Latitude: ${_latestPosition?.latitude}, Longitude: ${_latestPosition?.longitude}');
      }
    });
  }

  /// check geolocation permission
  Future<bool> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  FutureOr<void> _stopLocationTracking(StopLocationTracking event, Emitter<GeolocatorState> emit) {
    _positionStreamSubscription?.cancel();
    _locationTimer?.cancel();
    _locationTimer = null;
    emit(state.copyWith(status: GeolocatorStatus.idle));
  }

  FutureOr<void> _onLocationDataReceived(LocationDataReceived event, Emitter<GeolocatorState> emit) async {

    appLogger.d('LocationDataReceived ::: $event');

    // Calculate distance using Haversine formula
    final distanceInMeters = Geolocator.distanceBetween(event.position.latitude, event.position.longitude, _currentTarget?.targetLat ?? 0, _currentTarget?.targetLng ?? 0);

    final formattedDistance = DistanceCalculator.formatDistance(distanceInMeters);

    // Create record to be saved in storage(hive)
    final record = LocationRecordEntity(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      latitude: event.position.latitude,
      longitude: event.position.longitude,
      distance: distanceInMeters,
      formattedDistance: formattedDistance,
      targetId: _currentTarget?.id ?? '',
    );

    final model = LocationRecordModel.fromEntity(record);

    //save to hive
    await _hiveService.saveLocationRecord(model);

    // Update state to retain number of records a 100
    final updatedRecords = [record, ...state.records];
    if (updatedRecords.length > 100) {
      updatedRecords.removeLast();
    }

    emit(state.copyWith(records: updatedRecords, totalRecords: (state.totalRecords ?? 0) + 1));
  }

  FutureOr<void> _onLoadHistorialRecords(LoadHistoricalRecords event, Emitter<GeolocatorState> emit) async {
    final models = await _hiveService.getLocationRecords(limit: event.limit ?? 50);
    final entities = models.map((model) => model.toEntity()).toList();

    emit(state.copyWith(records: entities, totalRecords: entities.length));
  }

  FutureOr<void> _onUpdateFilterLimit(UpdateFilterLimit event, Emitter<GeolocatorState> emit) async {
    emit(state.copyWith(filterLimit: event.limit));
  }

  FutureOr<void> _onClearLocationHistory(ClearLocationHistory event, Emitter<GeolocatorState> emit) async {
    await _hiveService.clearAllRecords();
    emit(GeolocatorState());
  }
}
