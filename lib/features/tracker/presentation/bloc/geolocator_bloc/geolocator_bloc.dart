import 'dart:async';

import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocator_event.dart';
part 'geolocator_state.dart';

class GeolocatorBloc extends Bloc<GeolocatorEvent, GeolocatorState> {

  /// using stream 
  StreamSubscription<Position>? _positionStreamSubscription;
  Timer? _locationTimer;
  Position? _latestPosition;

  GeolocatorBloc() : super(GeolocatorState()) {
    on<StartLocationTracking>(_startLocationTracking);
    on<StopLocationTracking>(_stopLocationTracking);
    on<LocationTick>(_onLocationTick);
  }

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
    _locationTimer = Timer.periodic(event.interval, (timer) {
      if (_latestPosition != null) {
        add(LocationTick(_latestPosition!));
      }
    });

    appLogger.i('Positions::: ${_positionStreamSubscription?.isPaused}');
  }

  /// check permission checker
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

  void _onLocationTick(LocationTick event, Emitter<GeolocatorState> emit) {
    final updatedHistory = [event.position, ...state.locationHistory];
    // Keep only last 100 positions to manage memory
    if (updatedHistory.length > 100) {
      updatedHistory.removeLast();
    }

    emit(state.copyWith(currentLocation: event.position, locationHistory: updatedHistory, tickCount: state.tickCount + 1));

    appLogger.i('Position #${state.tickCount + 1}: ${event.position.latitude}, ${event.position.longitude}');
  }

  void _stopLocationTracking(StopLocationTracking event, Emitter<GeolocatorState> emit) {
    _positionStreamSubscription?.cancel();
    _locationTimer?.cancel();
    _locationTimer = null;
    emit(state.copyWith(status: GeolocatorStatus.idle));
  }

}
