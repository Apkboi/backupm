part of 'therapy_bloc.dart';

abstract class TherapyState extends Equatable {
  const TherapyState();
}

class TherapyInitial extends TherapyState {
  @override
  List<Object> get props => [];
}

class GetAvailableDatesLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class  GetAvailableDatesFailureState extends TherapyState {
  final String error;

  GetAvailableDatesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class  GetAvailableDatesSuccessState extends TherapyState {
  final FetchDatesResponse response;

  const GetAvailableDatesSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}



class GetUpcomingSessionsLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class GetUpcomingSessionsFailureState extends TherapyState {
  final String error;

  GetUpcomingSessionsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetUpcomingSessionsSuccessState extends TherapyState {
  final UpcomingSessionsResponse response;

  const GetUpcomingSessionsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}


class GetSessionsHistoryLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class GetSessionsHistoryFailureState extends TherapyState {
  final String error;

  GetSessionsHistoryFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetSessionsHistorySuccessState extends TherapyState {
  final UpcomingSessionsResponse response;

  const GetSessionsHistorySuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}