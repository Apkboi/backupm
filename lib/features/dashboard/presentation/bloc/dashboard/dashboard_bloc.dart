import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';
import 'package:mentra/features/dashboard/dormain/repository/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;
  ConversationStarterResponse? conversationStarter;

  DashboardBloc(this._dashboardRepository) : super(DashboardInitial()) {
    on<GetConversationStarterEvent>(_mapGetConversationStarterEventToState);
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
}
