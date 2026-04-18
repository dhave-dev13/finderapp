// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'target_location_bloc.dart';

class TargetLocationState extends Equatable {
  final FetchStatus? status;
  final TargetLocationModel? data;
  final String? message;
  const TargetLocationState({this.status = FetchStatus.initial, this.data, this.message});
  
  @override
  List<Object?> get props => [status, data];

  TargetLocationState copyWith({
    FetchStatus? status,
    TargetLocationModel? data,
  }) {
    return TargetLocationState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
