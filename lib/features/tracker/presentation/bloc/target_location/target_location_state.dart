// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'target_location_bloc.dart';

class TargetLocationState extends Equatable {
  final FetchStatus? status;
  final TargetLocationEntity? data;
  final String? message;
  final bool hasData;
  const TargetLocationState({this.status = FetchStatus.initial, this.data, this.message, this.hasData = false});
  
  @override
  List<Object?> get props => [status, data, message, hasData];

  TargetLocationState copyWith({
    FetchStatus? status,
    TargetLocationEntity? data,
    String? message,
    bool? hasData
  }) {
    return TargetLocationState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      hasData: hasData ?? this.hasData,
    );
  }
}
