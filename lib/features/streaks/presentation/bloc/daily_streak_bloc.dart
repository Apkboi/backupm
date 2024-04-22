import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/streaks/data/model/get_streaks_response.dart';
import 'package:mentra/features/streaks/domain/repository/steaks_repository.dart';

part 'daily_streak_event.dart';

part 'daily_streak_state.dart';

class DailyStreakBloc extends Bloc<DailyStreakEvent, DailyStreakState> {
  final StreaksRepository _repository;
  List<BadgeModel> badges = [];

  DailyStreakBloc(this._repository) : super(DailyStreakInitial()) {
    on<DailyStreakEvent>((event, emit) {});
    on<GetDailyStreakEvent>(_mapGetStreksEventToState);
  }

  FutureOr<void> _mapGetStreksEventToState(
      GetDailyStreakEvent event, Emitter<DailyStreakState> emit) async {
    emit(GetStreaksLoadingState());
    try {
      var response = await _repository.getStreaks();
      badges = response.data;
      emit(GetStreaksSuccessState(response));
    } catch (e, stack) {
      emit(GetStreaksFailureState(e.toString()));
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
