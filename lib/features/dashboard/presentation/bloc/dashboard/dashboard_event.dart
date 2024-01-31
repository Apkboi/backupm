part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

// Event
class GetConversationStarterEvent extends DashboardEvent {
  @override
  List<Object?> get props => [];
}
class GetEmergencyContactsEvent extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

