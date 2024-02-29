part of 'notification_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

// State classes
class GetNotificationsLoadingState extends NotificationsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NotificationsInitial extends NotificationsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetNotificationsSuccessState extends NotificationsState {
  final GetNotificationsResponse response;

  GetNotificationsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetNotificationsFailureState extends NotificationsState {
  final String error;

  GetNotificationsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadNotificationSuccessState extends NotificationsState {
  final ReadNotificationResponse response;

  const ReadNotificationSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ReadNotificationFailureState extends NotificationsState {
  final String error;

  ReadNotificationFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetNotificationsDetailsLoadingState extends NotificationsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetNotificationsDetailsSuccessState extends NotificationsState {
  final dynamic details;

  GetNotificationsDetailsSuccessState({required this.details});

  @override
  List<Object?> get props => [details];
}

class GetNotificationsDetailsFailureState extends NotificationsState {
  final String error;

  GetNotificationsDetailsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
