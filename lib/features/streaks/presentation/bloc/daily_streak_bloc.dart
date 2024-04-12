import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'daily_streak_event.dart';
part 'daily_streak_state.dart';

class DailyStreakBloc extends Bloc<DailyStreakEvent, DailyStreakState> {
  DailyStreakBloc() : super(DailyStreakInitial()) {
    on<DailyStreakEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
