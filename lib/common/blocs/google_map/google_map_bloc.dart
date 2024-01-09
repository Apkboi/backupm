import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'google_map_event.dart';

part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  dynamic googleMapServices = Object();

  GoogleMapBloc() : super(GoogleMapInitial()) {
    on<GoogleMapEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchPlaceEvent>(_mapSearchPlaceEvent);
  }

  FutureOr<void> _mapSearchPlaceEvent(
      SearchPlaceEvent event, Emitter<GoogleMapState> emit) async {
    emit(SearchPlaceLoading());
    try {
      await googleMapServices.searchPlace(event.query).fold(
          (left) => emit(SearchPlaceFailure(left.errorMessage)),
          (right) => emit(SearchPlaceSuccess(right)));
    } on Exception catch (e) {
      emit(SearchPlaceFailure(e.toString()));
    }
  }
}
