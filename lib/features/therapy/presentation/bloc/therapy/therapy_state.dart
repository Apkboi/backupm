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

class MatchTherapistLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class MatchTherapistSuccessState extends TherapyState {
  final MatchTherapistResponse response;

  const MatchTherapistSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class MatchTherapistFailureState extends TherapyState {
  final String error;

  const MatchTherapistFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class AcceptTherapistLoadingState extends TherapyState {
  @override
  List<Object?> get props => [];
}

class AcceptTherapistSuccessState extends TherapyState {
  final AcceptTherapistResponse response;

  const AcceptTherapistSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class AcceptTherapistFailureState extends TherapyState {
  final String error;

  const AcceptTherapistFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class TherapistAcceptedState extends TherapyState {
  const TherapistAcceptedState();

  @override
  List<Object?> get props => [];
}

class GetMatchedTherapistSuccessState extends TherapyState {
  final GetMatchedTherapistResponse response;

  const GetMatchedTherapistSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetMatchedTherapistFailureState extends TherapyState {
  final String error;

  const GetMatchedTherapistFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetMatchedTherapistLoadingState extends TherapyState {
  const GetMatchedTherapistLoadingState();

  @override
  List<Object?> get props => [];
}

class CreateReviewSuccessState extends TherapyState {
  final SuccessResponse response;

  const CreateReviewSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class CreateReviewFailureState extends TherapyState {
  final String error;

  const CreateReviewFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class CreateReviewLoadingState extends TherapyState {
  const CreateReviewLoadingState();

  @override
  List<Object?> get props => [];
}

class GetTherapistReviewsSuccessState extends TherapyState {
  final SuccessResponse response;

  const GetTherapistReviewsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetTherapistReviewsFailureState extends TherapyState {
  final String error;

  const GetTherapistReviewsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetTherapistReviewsLoadingState extends TherapyState {
  const GetTherapistReviewsLoadingState();

  @override
  List<Object?> get props => [];
}
