import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deep_link_event.dart';

part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  DeepLinkBloc() : super(DeepLinkInitial()) {
    dynamic data;

    on<DeepLinkEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<DeepLinkReceived>((event, emit) {
      data = event.deepLink;
      emit(ActiveDeepLink(event.deepLink));
    });
    on<CheckForDeepLink>((event, emit) {
      if (data != null) {
        emit(ActiveDeepLink(data));
      }
    });

    on<DeepLinkCleared>((event, emit) {
      data = null;
      emit(NoDeepLink());
    });
  }
}
