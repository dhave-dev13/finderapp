part of 'tracker_cubit.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerInitial extends TrackerState {}
