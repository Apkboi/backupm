// Event classes
import 'package:equatable/equatable.dart';

abstract class TherapyEvent extends Equatable {
  const TherapyEvent();
}

class GetUpcomingSessionsEvent extends TherapyEvent {
  @override
  List<Object?> get props => [];
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
  final dynamic payload;

  CreateSessionEvent({required this.payload});

  @override
  List<Object?> get props => [payload];
}






