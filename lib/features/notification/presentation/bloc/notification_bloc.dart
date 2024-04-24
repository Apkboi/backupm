import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/notification/data/models/get_notifications_response.dart';
import 'package:mentra/features/notification/data/models/read_notification_response.dart';
import 'package:mentra/features/notification/presentation/dormain/repository/notifications_repository.dart';

part 'notification_event.dart';

part 'notification_state.dart';

// Bloc class
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _notificationsRepository;
  List<MentraNotification> allNotification = [];

  NotificationsBloc(this._notificationsRepository)
      : super(NotificationsInitial()) {
    on<GetNotificationsEvent>(_mapGetNotificationsEventToState);
    on<ReadNotificationEvent>(_mapReadNotificationEventToState);
    on<GetNotificationsDetailsEvent>(_mapGetNotificationsDetailsEventToState);
    on<ClearNotificationsEvent>(_mapClearNotificationsEventToState);
  }

  Future<void> _mapGetNotificationsEventToState(
    GetNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(GetNotificationsLoadingState());
    try {
      final notifications = await _notificationsRepository.getNotifications();

      allNotification = notifications.data;
      emit(GetNotificationsSuccessState(response: notifications));
    } catch (e) {
      emit(GetNotificationsFailureState(error: e.toString()));
    }
  }

  Future<void> _mapReadNotificationEventToState(
    ReadNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    // emit(ReadNotificationLoading());
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

  FutureOr<void> _mapClearNotificationsEventToState(
      ClearNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(ClearNotificationsDetailsLoadingState());
    try {
      final details = await _notificationsRepository.clearAllNotifications();
      emit(ClearNotificationsDetailsSuccessState(details: details));
    } catch (e) {
      emit(ClearNotificationsDetailsFailureState(error: e.toString()));
    }
  }
}
