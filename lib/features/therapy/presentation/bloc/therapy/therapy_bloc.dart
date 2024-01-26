import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/data/models/create_sessions_payload.dart';
import 'package:mentra/features/therapy/presentation/data/models/fetch_dates_response.dart';
import 'package:mentra/features/therapy/presentation/data/models/fetch_time_slots_response.dart';
import 'package:mentra/features/therapy/presentation/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/dormain/repository/therapy_repository.dart';

part 'therapy_state.dart';
enum SessionFlow{
  schedule,
  reSchedule,
  none,
}
// Bloc class
class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  final TherapyRepository _therapyRepository;

  TherapyBloc(this._therapyRepository) : super(TherapyInitial()) {
    on<GetUpcomingSessionsEvent>(_mapGetUpcomingSessionsEventToState);
    on<GetSessionHistoryEvent>(_mapGetSessionHistoryEventToState);
    on<GetAvailableDatesEvent>(_mapGetAvailableDatesEventToState);
    on<GetTimeSlotsEvent>(_mapGetTimeSlotsEventToState);
    on<CreateSessionEvent>(_mapCreateSessionEventToState);
  }

  CreateSessionPayload createSessionsPayload = CreateSessionPayload.empty();
  SessionFlow currentSessionFlow = SessionFlow.none;

  Future<void> _mapGetUpcomingSessionsEventToState(
    GetUpcomingSessionsEvent event,
    Emitter<TherapyState> emit,
  ) async {
    emit(GetUpcomingSessionsLoadingState());
    try {
      final sessions = await _therapyRepository.getUpcomingSessions();
      emit(GetUpcomingSessionsSuccessState(response: sessions));
    } catch (e) {
      emit(GetUpcomingSessionsFailureState(error: e.toString()));
    }
  }



  FutureOr<void> _mapGetSessionHistoryEventToState(
      GetSessionHistoryEvent event, Emitter<TherapyState> emit)async {

    emit(GetSessionsHistoryLoadingState());
    try {
      final response = await _therapyRepository.getSessionsHistory();
      emit(GetSessionsHistorySuccessState(response: response));
    } catch (e) {
      emit(GetSessionsHistoryFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetAvailableDatesEventToState(
      GetAvailableDatesEvent event, Emitter<TherapyState> emit) async {
    emit(GetAvailableDatesLoadingState());
    try {
      final sessions = await _therapyRepository.getAvailableDate();
      emit(GetAvailableDatesSuccessState(response: sessions));
    } catch (e) {
      emit(GetAvailableDatesFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetTimeSlotsEventToState(
      GetTimeSlotsEvent event, Emitter<TherapyState> emit) async{

    emit(GetTimeSlotsoadingState());
    try {
      final sessions = await _therapyRepository.getAvailableTimeSlots(event.date);
      emit(GetTimeSlotsSuccessState(response: sessions));
    } catch (e) {
      emit(GetTimeSlotsFailureState(error: e.toString()));
    }

  }

  FutureOr<void> _mapCreateSessionEventToState(
      CreateSessionEvent event, Emitter<TherapyState> emit) {}


  // Method to update fields in the payload
  void updatePayload({
    DateTime? date,
    String? time,
    String? focus,
    String? note,
  }) {
    createSessionsPayload = createSessionsPayload.copyWith(
      date: date ?? createSessionsPayload.date,
      time: time ?? createSessionsPayload.time,
      focus: focus ?? createSessionsPayload.focus,
      note: note ?? createSessionsPayload.note,
    );
  }

  // Method to clear fields in the payload
  void clearPayload() {
    createSessionsPayload = CreateSessionPayload.empty();
  }
}
