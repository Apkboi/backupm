part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

// States
class GetConversationStarterLoadingState extends DashboardState {
  @override
  List<Object?> get props => [];
}

class GetConversationStarterFailureState extends DashboardState {
  final String error;

  const GetConversationStarterFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetConversationStarterSuccessState extends DashboardState {
  final ConversationStarterResponse data;

  const GetConversationStarterSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetEmergencyContactLoadingState extends DashboardState {
  @override
  List<Object?> get props => [];
}

class GetEmergencyContactFailureState extends DashboardState {
  final String error;

  const GetEmergencyContactFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetEmergencyContactSuccessState extends DashboardState {
  final GetEmergencyContactsResponse data;

  const GetEmergencyContactSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}
