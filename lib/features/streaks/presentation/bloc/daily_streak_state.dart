part of 'daily_streak_bloc.dart';

abstract class DailyStreakState extends Equatable {
  const DailyStreakState();
}

class DailyStreakInitial extends DailyStreakState {
  @override
  List<Object> get props => [];
}

class GetStreaksLoadingState extends DailyStreakState {
  @override
  List<Object> get props => [];
}

class GetStreaksSuccessState extends DailyStreakState {
  final GetStreaksResponse response;

  const GetStreaksSuccessState(this.response);

  @override
  List<Object> get props => [];
}

class GetStreaksFailureState extends DailyStreakState {
  final String error;

  const GetStreaksFailureState(this.error);

  @override
  List<Object> get props => [error];
}
