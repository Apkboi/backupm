import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/notification/presentation/dormain/repository/notifications_repository.dart';

part 'notification_event.dart';

part 'notification_state.dart';

// Bloc class
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _notificationsRepository;

  NotificationsBloc(this._notificationsRepository)
      : super(NotificationsInitial()) {
    on<GetNotificationsEvent>(_mapGetNotificationsEventToState);
    on<ReadNotificationEvent>(_mapReadNotificationEventToState);
    on<GetNotificationsDetailsEvent>(_mapGetNotificationsDetailsEventToState);
  }

  Future<void> _mapGetNotificationsEventToState(
    GetNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(GetNotificationsLoadingState());
    try {
      final notifications = await _notificationsRepository.getNotifications();
      emit(GetNotificationsSuccessState(notifications: notifications));
    } catch (e) {
      emit(GetNotificationsFailureState(error: e.toString()));
    }
  }

  Future<void> _mapReadNotificationEventToState(
    ReadNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(GetNotificationsLoadingState());
    try {
      final response =
          await _notificationsRepository.readNotification(event.id);
      emit(ReadNotificationSuccessState(response: response));
    } catch (e) {
      emit(ReadNotificationFailureState(error: e.toString()));
    }
  }

  Future<void> _mapGetNotificationsDetailsEventToState(
    GetNotificationsDetailsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(GetNotificationsDetailsLoadingState());
    try {
      final details =
          await _notificationsRepository.getNotificationDetails(event.id);
      emit(GetNotificationsDetailsSuccessState(details: details));
    } catch (e) {
      emit(GetNotificationsDetailsFailureState(error: e.toString()));
    }
  }
}
