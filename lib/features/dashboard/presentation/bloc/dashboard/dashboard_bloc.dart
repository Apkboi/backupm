import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';
import 'package:mentra/features/dashboard/data/models/emergency_contacts.dart';
import 'package:mentra/features/dashboard/dormain/repository/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;
  ConversationStarterResponse? conversationStarter;

  DashboardBloc(this._dashboardRepository) : super(DashboardInitial()) {
    on<GetConversationStarterEvent>(_mapGetConversationStarterEventToState);
    on<GetEmergencyContactsEvent>(_mapGetEmergencyContactsEventToState);
  }

  Future<void> _mapGetConversationStarterEventToState(
    GetConversationStarterEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(GetConversationStarterLoadingState());
    try {
      final conversationStarterData =
          await _dashboardRepository.getConversationStarter();
      conversationStarter = conversationStarterData;
      emit(GetConversationStarterSuccessState(data: conversationStarterData));
    } catch (e) {
      emit(GetConversationStarterFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetEmergencyContactsEventToState(
      GetEmergencyContactsEvent event, Emitter<DashboardState> emit) async {
    emit(GetEmergencyContactLoadingState());
    try {
      final response = await _dashboardRepository.getEmergencyContacts();
      emit(GetEmergencyContactSuccessState(data: response));
    } catch (e,stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetEmergencyContactFailureState(error: e.toString()));
    }
  }
}
