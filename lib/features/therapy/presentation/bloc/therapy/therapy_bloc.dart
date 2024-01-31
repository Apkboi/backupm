import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/therapy/data/models/accept_therapist_response.dart';
import 'package:mentra/features/therapy/data/models/change_therapist_message_model.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/data/models/create_session_response.dart';
import 'package:mentra/features/therapy/data/models/create_sessions_payload.dart';
import 'package:mentra/features/therapy/data/models/fetch_dates_response.dart';
import 'package:mentra/features/therapy/data/models/fetch_time_slots_response.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/dormain/repository/therapy_repository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'therapy_state.dart';

enum SessionFlow {
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
    on<RescheduleSessionEvent>(_mapRescheduleSessionEventToState);
    on<CancelSessionEvent>(_mapCancelSessionEventToState);
    on<MatchTherapistEvent>(_mapMatchTherapistEventToState);
    on<SelectTherapistEvent>(_mapSelectTherapistEventToState);
    on<TherapistAcceptedEvent>(_mapStartChangeTherapistConversationToState);
  }

  final scrollController = ItemScrollController();

  void _scrollToLast() async {


    scrollController.jumpTo(
      alignment:0.5,
      index: 0,


    );


  }

  CreateSessionPayload createSessionsPayload = CreateSessionPayload.empty();
  SessionFlow currentSessionFlow = SessionFlow.none;
  List<ChangeTherapistMessageModel> changeTherapistMessages = [];

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
      GetSessionHistoryEvent event, Emitter<TherapyState> emit) async {
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
      GetTimeSlotsEvent event, Emitter<TherapyState> emit) async {
    emit(GetTimeSlotsoadingState());
    try {
      final sessions =
          await _therapyRepository.getAvailableTimeSlots(event.date);
      emit(GetTimeSlotsSuccessState(response: sessions));
    } catch (e) {
      emit(GetTimeSlotsFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapCreateSessionEventToState(
      CreateSessionEvent event, Emitter<TherapyState> emit) async {
    emit(CreateSessionLoadingState());
    try {
      final response = await _therapyRepository.createSession(event.payload);
      clearPayload();
      emit(CreateSessionSuccessState(response: response));
    } catch (e) {
      emit(CreateSessionFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapRescheduleSessionEventToState(
      RescheduleSessionEvent event, Emitter<TherapyState> emit) async {
    emit(RescheduleSessionLoadingState());
    try {
      final response =
          await _therapyRepository.rescheduleSession(event.payload);
      clearPayload();
      emit(RescheduleSessionSuccessState(response: response));
    } catch (e) {
      emit(RescheduleSessionFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapCancelSessionEventToState(
      CancelSessionEvent event, Emitter<TherapyState> emit) async {
    emit(CancelSessionLoadingState());
    try {
      final response = await _therapyRepository.cancelSession(
        sessionId: event.sessionId,
        note: event.note,
      );

      emit(CancelSessionSessionSuccessState(response: response));
    } catch (e) {
      emit(CancelSessionSessionFailureState(error: e.toString()));
    }
  }

  Future<void> _mapMatchTherapistEventToState(
    MatchTherapistEvent event,
    Emitter<TherapyState> emit,
  ) async {
    changeTherapistMessages.add(ChangeTherapistMessageModel(
        messageType: ChangeTherapistMessageType.reply,
        isSender: false,
        time: DateTime.now(),
        message: [
          if (event.updatedPreference)
            "Thank you for providing your preferences. Give me a moment to find a therapist that matches your criteria. ",
          if (!event.updatedPreference)
            'Give me a moment to find a therapist that matches your criteria. '
        ]));
    changeTherapistMessages.add(ChangeTherapistMessageModel(
        messageType: ChangeTherapistMessageType.processing,
        isSender: false,
        time: DateTime.now(),
        message: ["[Processing...]"]));
    _scrollToLast();

    emit(MatchTherapistLoadingState());
    try {
      final response = await _therapyRepository.matchTherapist();

      changeTherapistMessages.add(ChangeTherapistMessageModel(
          messageType: ChangeTherapistMessageType.reply,
          isSender: false,
          time: DateTime.now(),
          therapist: response.data,
          message: [
            "Great news! I've found a therapist who matches your preferences. Their name is ${response.data.user.name}, and they specialize in ${response.data.therapist.techniquesOfExpertise.firstOrNull}. ${response.data.user.name} is a ${response.data.therapist.gender} therapist who speaks ${response.data.therapist.languagesSpoken}."
          ]));
      changeTherapistMessages.add(ChangeTherapistMessageModel(
          messageType: ChangeTherapistMessageType.therapistSuggestion,
          isSender: true,
          therapist: response.data,
          time: DateTime.now(),
          message: []));
      _scrollToLast();
      emit(MatchTherapistSuccessState(response: response));
    } catch (e) {
      emit(MatchTherapistFailureState(error: e.toString()));
      changeTherapistMessages.add(ChangeTherapistMessageModel(
          messageType: ChangeTherapistMessageType.retry,
          isSender: false,
          time: DateTime.now(),
          message: [e.toString()]));
      changeTherapistMessages.add(ChangeTherapistMessageModel(
          messageType: ChangeTherapistMessageType.retry,
          isSender: false,
          time: DateTime.now(),
          message: ["Retry"]));
      _scrollToLast();
    }
  }

  Future<void> _mapSelectTherapistEventToState(
    SelectTherapistEvent event,
    Emitter<TherapyState> emit,
  ) async {
    emit(AcceptTherapistLoadingState());
    try {
      var response = await _therapyRepository.acceptTherapist(
        therapistId: event.therapistUserId,
      );
      changeTherapistMessages.add(ChangeTherapistMessageModel(
          messageType: ChangeTherapistMessageType.reply,
          isSender: false,
          time: DateTime.now(),
          message: [
            "Congratulations! You are now connected with . If you need any help getting started, feel free to ask. ",
            'Good luck with your therapy sessions!'
          ]));
      _scrollToLast();

      emit(AcceptTherapistSuccessState(response: response));
    } catch (e) {
      emit(AcceptTherapistFailureState(error: e.toString()));
    }
  }

  // Method to update fields in the payload
  void updatePayload({
    DateTime? date,
    String? time,
    String? focus,
    String? note,
    String? sessionId,
  }) {
    createSessionsPayload = createSessionsPayload.copyWith(
      date: date ?? createSessionsPayload.date,
      time: time ?? createSessionsPayload.time,
      focus: focus ?? createSessionsPayload.focus,
      note: note ?? createSessionsPayload.note,
      sessionId: sessionId ?? createSessionsPayload.sessionId,
    );
  }

  // Method to clear fields in the payload
  void clearPayload() {
    createSessionsPayload = CreateSessionPayload.empty();
  }

  void scheduleOrRescheduleSession() {
    if (currentSessionFlow == SessionFlow.schedule) {
      add(CreateSessionEvent(payload: createSessionsPayload));
    } else {
      add(RescheduleSessionEvent(payload: createSessionsPayload));
    }
  }

  FutureOr<void> _mapStartChangeTherapistConversationToState(
      TherapistAcceptedEvent event, Emitter<TherapyState> emit) {
    changeTherapistMessages.add(ChangeTherapistMessageModel(
        messageType: ChangeTherapistMessageType.reply,
        isSender: false,
        time: DateTime.now(),
        message: [
          "Congratulations! You are now connected with . If you need any help getting started, feel free to ask. ",
          'Good luck with your therapy sessions!'
        ]));
    _scrollToLast();
    emit(const TherapistAcceptedState());
  }
}
