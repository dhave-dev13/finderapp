part of 'target_location_bloc.dart';

abstract class TargetLocationEvent extends Equatable {
  const TargetLocationEvent();

  @override
  List<Object?> get props => [];
}

class GetTargetLocation extends TargetLocationEvent {}

class ClearTargetLocation extends TargetLocationEvent {}

class ResetTargetLocation extends TargetLocationEvent {}
