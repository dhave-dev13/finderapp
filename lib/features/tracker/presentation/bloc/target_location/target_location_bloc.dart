import 'dart:async';

import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/enums.dart';
import 'package:finderapp/features/tracker/domain/entities/target_location_entity.dart';
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
    on<ClearTargetLocation>(_clearTargetLocation);
    on<ResetTargetLocation>(_onResetTargetLocation);
  }

  FutureOr<void> _getTargetLocation(GetTargetLocation event, Emitter<TargetLocationState> emit) async {
    // Only fetch if we don't already have data
    if (state.hasData) {
      return;
    }

    emit(state.copyWith(status: FetchStatus.loading));

    final dataError = await locationUseCase();

    dataError.fold(
      (error) {
        emit(state.copyWith(status: FetchStatus.failed, message: error.message, hasData: false));
      },
      (targetLocationData) {
        appLogger.d('GetTargetLocationData ::: $targetLocationData');
        emit(state.copyWith(status: FetchStatus.loaded, data: targetLocationData, message: null, hasData: true));
      },
    );
  }

  FutureOr<void> _clearTargetLocation(ClearTargetLocation event, Emitter<TargetLocationState> emit) {
    emit(const TargetLocationState());
  }

  FutureOr<void> _onResetTargetLocation(ResetTargetLocation event, Emitter<TargetLocationState> emit) async {
    emit(const TargetLocationState());
  }
}
