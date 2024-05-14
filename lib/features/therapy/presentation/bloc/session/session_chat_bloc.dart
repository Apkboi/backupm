import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/core/services/sentory/sentory_service.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/data/models/get_all_messages_response.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';
import 'package:mentra/features/therapy/dormain/repository/session_chat_repository.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

part 'session_chat_event.dart';

part 'session_chat_state.dart';

class SessionChatBloc extends Bloc<SessionChatEvent, SessionChatState> {
  final SessionChatRepository _chatRepository;

  // static final MesiboUI _mesiboUi = MesiboUI();
  // MesiboProfile? profile;
  List<TherapyChatMessage> messages = [];

  SessionChatBloc(this._chatRepository) : super(SessionInitial()) {
    on<SessionChatEvent>((event, emit) {});
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
    on<MessageReceivedEvent>(_mapMessageReceivedEventToState);
  }

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<SessionChatState> emit) async {
    messages.add(event.message);
    emit(SendMessageLoadingState());
    final response = await _chatRepository.sendMessage(event.message);

    emit(SendMessageSuccesState());
  }

  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<SessionChatState> emit) async {
    // _listenForMessages();

    try {
      emit(GetMessagesLoadingState());
      var response = await _chatRepository.getMessages();

      messages = response.data
          .map((e) => TherapyChatMessage.fromChatMessage(e))
          .toList();

      emit(MessagesUpdatedState());
    } catch (e) {

      emit(GetMessagesFailedState(e.toString()));
      rethrow;
      // TODO
    }
  }

  void _listenForMessages() async {
    logger.w('listening');

    try {
      var pusherService = await PusherChannelService.getInstance;
      var pusher = await pusherService.getClient;
      if (pusher != null) {
        logger.w('connecting');
        if (!pusher.channels
            .containsKey(injector.get<UserBloc>().userChannel)) {
          PusherChannel channel = await pusher.subscribe(
            channelName: injector.get<UserBloc>().userChannel,
            onSubscriptionError: (message, d) =>
                onSubscriptionError(message, d),
            onSubscriptionSucceeded: (data) {
              // log('subscribed');
              // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
              // return data;a
            },
            onEvent: (event) => onEventReceived(event),
          );
          logger.w('connected');
        } else {
          logger.w('connected2');
          pusher.getChannel(injector.get<UserBloc>().userChannel)?.onEvent =
              onEventReceived;
        }
        await pusher.connect();
      }
    } catch (e, s) {
      SentryService.captureException(e, stackTrace: s);
    }
  }

  // void _addMessage(MesiboMessage message) {
  //
  // }

  FutureOr<void> _mapMessageReceivedEventToState(
      MessageReceivedEvent event, Emitter<SessionChatState> emit) {
    if (messages.any((element) => element.id != event.message.toString())) {
      messages.add(TherapyChatMessage(
          message: event.message.message.toString(),
          time: DateTime.now(),
          isTherapist: event.message.isTherapist,
          id: event.message.id));

      emit(MessagesFetchedEvent());
    }
  }

  onSubscriptionError(message, d) {}

  onEventReceived(event) {
    injector.get<PusherCubit>().triggerPusherEvent(event);

    logger.i(event);
  }
}
