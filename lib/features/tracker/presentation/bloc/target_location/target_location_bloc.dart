import 'dart:async';

import 'package:finderapp/core/utils/enums.dart';
import 'package:finderapp/features/tracker/data/models/target_location_model.dart';
import 'package:finderapp/features/tracker/domain/usecases/get_target_location_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'target_location_event.dart';
part 'target_location_state.dart';

class TargetLocationBloc extends Bloc<TargetLocationEvent, TargetLocationState> {
  final locationUseCase = GetIt.instance<GetTargetLocationUsecase>();
  TargetLocationBloc() : super(TargetLocationState()) {
    on<GetTargetLocation>(_getTargetLocation);
  }

  FutureOr<void> _getTargetLocation(GetTargetLocation event, Emitter<TargetLocationState> emit) async {
    emit(state.copyWith(status: FetchStatus.loading));

    try {
      final dataError = await locationUseCase();

      dataError.fold((error) {
        emit(state.copyWith(status: FetchStatus.failed));
      }, (data) {
        emit(state.copyWith(status: FetchStatus.success, data: data));
      });
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failed));
    }

  }
}
