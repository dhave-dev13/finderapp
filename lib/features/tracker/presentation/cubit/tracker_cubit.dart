import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

part 'tracker_state.dart';

class TrackerToggleCubit extends Cubit<bool> {
  TrackerToggleCubit() : super(false);

  Future<void> toggleLocationTracking() async {
    final permission = Permission.location;

    Logger().i('permission_status :: ${permission.status}');

    if (await permission.isDenied || await permission.isPermanentlyDenied) {
      await permission.request();
    }
    emit(!state);
  }
}
