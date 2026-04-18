import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'geolocator_event.dart';
part 'geolocator_state.dart';

class GeolocatorBloc extends Bloc<GeolocatorEvent, GeolocatorState> {
  GeolocatorBloc() : super(GeolocatorInitial()) {
    on<GeolocatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
