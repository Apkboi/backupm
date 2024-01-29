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

class GetAvailableDatesFailureState extends TherapyState {
  final String error;

  GetAvailableDatesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetAvailableDatesSuccessState extends TherapyState {
  final FetchDatesResponse response;

  const GetAvailableDatesSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetTimeSlotsoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class GetTimeSlotsFailureState extends TherapyState {
  final String error;

  GetTimeSlotsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetTimeSlotsSuccessState extends TherapyState {
  final FetchTimeSlotsResponse response;

  const GetTimeSlotsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetUpcomingSessionsLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class GetUpcomingSessionsFailureState extends TherapyState {
  final String error;

  const GetUpcomingSessionsFailureState({required this.error});

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

  const GetSessionsHistoryFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetSessionsHistorySuccessState extends TherapyState {
  final UpcomingSessionsResponse response;

  const GetSessionsHistorySuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class CreateSessionLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class CreateSessionFailureState extends TherapyState {
  final String error;

  const CreateSessionFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class CreateSessionSuccessState extends TherapyState {
  final CreateSessionResponse response;

  const CreateSessionSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class RescheduleSessionLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class RescheduleSessionFailureState extends TherapyState {
  final String error;

  const RescheduleSessionFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class RescheduleSessionSuccessState extends TherapyState {
  final CreateSessionResponse response;

  const RescheduleSessionSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class CancelSessionLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class CancelSessionSessionFailureState extends TherapyState {
  final String error;

  const CancelSessionSessionFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class CancelSessionSessionSuccessState extends TherapyState {
  final CreateSessionResponse response;

  const CancelSessionSessionSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}
