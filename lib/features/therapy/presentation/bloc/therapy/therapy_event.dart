// Event classes
import 'package:equatable/equatable.dart';
import 'package:mentra/features/therapy/data/models/create_sessions_payload.dart';

abstract class TherapyEvent extends Equatable {
  const TherapyEvent();
}

class GetUpcomingSessionsEvent extends TherapyEvent {
  @override
  List<Object?> get props => [];
}

class ReportEvent extends TherapyEvent {
  final String content;

  const ReportEvent(this.content);

  @override
  List<Object?> get props => [content];
}

class GetSessionHistoryEvent extends TherapyEvent {
  @override
  List<Object?> get props => [];
}

class GetAvailableDatesEvent extends TherapyEvent {
  @override
  List<Object?> get props => [];
}

class GetTimeSlotsEvent extends TherapyEvent {
  final String date;

  GetTimeSlotsEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

class CreateSessionEvent extends TherapyEvent {
  final CreateSessionPayload payload;

  CreateSessionEvent({required this.payload});

  @override
  List<Object?> get props => [payload];
}

class RescheduleSessionEvent extends TherapyEvent {
  final CreateSessionPayload payload;

  const RescheduleSessionEvent({required this.payload});

  @override
  List<Object?> get props => [payload];
}

class CancelSessionEvent extends TherapyEvent {
  final String sessionId;
  final String? note;

  const CancelSessionEvent({required this.sessionId, this.note});

  @override
  List<Object?> get props => [sessionId, note];
}

class MatchTherapistEvent extends TherapyEvent {
  final bool updatedPreference;

  const MatchTherapistEvent({required this.updatedPreference});

  @override
  List<Object?> get props => [];
}

class SelectTherapistEvent extends TherapyEvent {
  final String therapistUserId;

  SelectTherapistEvent({required this.therapistUserId});

  @override
  List<Object?> get props => [therapistUserId];
}

class TherapistAcceptedEvent extends TherapyEvent {
  const TherapistAcceptedEvent();

  @override
  List<Object?> get props => [];
}

class GetMatchedTherapistEvent extends TherapyEvent {
  const GetMatchedTherapistEvent();

  @override
  List<Object?> get props => [];
}

class CreateReviewEvent extends TherapyEvent {
  const CreateReviewEvent(
      {required this.sessionId,
      required this.comment,
      required this.videoRating,
      required this.audioRating,
      required this.sessionRating});

  final String sessionId;
  final String comment;
  final int sessionRating;
  final int videoRating;
  final int audioRating;

  @override
  List<Object?> get props => [];
}

class GetTherapistReviewsEvent extends TherapyEvent {
  const GetTherapistReviewsEvent();

  @override
  List<Object?> get props => [];
}

class GetSessionFocusEvent extends TherapyEvent {
  const GetSessionFocusEvent();

  @override
  List<Object?> get props => [];
}
