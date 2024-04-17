part of 'daily_streak_bloc.dart';

abstract class DailyStreakEvent extends Equatable {
  const DailyStreakEvent();
}

class GetDailyStreakEvent extends DailyStreakEvent {
  @override
  List<Object?> get props => [];
}
