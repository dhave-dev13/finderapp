import 'dart:async';
import 'package:flutter/material.dart';
import 'package:finderapp/core/utils/app_logger.dart';

class AppLifecycleService with WidgetsBindingObserver {
  // Stream controller for lifecycle changes
  final _lifecycleController = StreamController<AppLifecycleState>.broadcast();
  Stream<AppLifecycleState> get lifecycleStream => _lifecycleController.stream;
  
  // Current app state
  AppLifecycleState _currentState = AppLifecycleState.resumed;
  AppLifecycleState get currentState => _currentState;
  
  // Convenience getters
  bool get isAppInForeground => _currentState == AppLifecycleState.resumed;
  bool get isAppInBackground => 
      _currentState == AppLifecycleState.paused || 
      _currentState == AppLifecycleState.inactive;
  
  void init() {
    WidgetsBinding.instance.addObserver(this);
    appLogger.i('AppLifecycleService initialized');
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    _lifecycleController.add(state);
    appLogger.d('App lifecycle changed: $state');
  }
  
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lifecycleController.close();
  }
}