part of 'notification_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class GetNotificationsEvent extends NotificationsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReadNotificationEvent extends NotificationsEvent {
  final String id;

  const ReadNotificationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetNotificationsDetailsEvent extends NotificationsEvent {
  final String id;

  const GetNotificationsDetailsEvent(this.id);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClearNotificationsEvent extends NotificationsEvent {
  const ClearNotificationsEvent();

  @override
  List<Object?> get props => [];
}
