import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/core/services/sentory/sentory_service.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/therapy/data/models/get_all_messages_response.dart';
import 'package:mentra/features/therapy/data/models/new_message_response.dart';
import 'package:mentra/features/therapy/data/models/send_message_response.dart';
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

  String conversationId = '';

  SessionChatBloc(this._chatRepository) : super(SessionInitial()) {
    on<SessionChatEvent>((event, emit) {});
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<ResendMessageEvent>(_mapRetryMessageEventToState);
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
    on<MessageReceivedEvent>(_mapMessageReceivedEventToState);
  }

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<SessionChatState> emit) async {
    messages.insert(0, event.message);
    emit(SendMessageLoadingState());
    try {
      final response = await _chatRepository.sendMessage(event.message);

      if (messages.length < 2) {
        conversationId = response.data.conversationId.toString();
        _listenForMessages(response.data.conversationId.toString());
      }

      messages
          .where((element) => element.id == event.message.id)
          .first
          .sendingState = SendingState.success;

      emit(SendMessageSuccesState());
    } catch (e) {
      messages
          .where((element) => element.id == event.message.id)
          .first
          .sendingState = SendingState.failed;
      emit(SendMessageFailedState());
    }
  }

  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<SessionChatState> emit) async {
    try {
      emit(GetMessagesLoadingState());
      var response = await _chatRepository.getMessages(event.therapistId);

      messages = response.data
          .map((e) => TherapyChatMessage.fromChatMessage(e))
          .toList();

      emit(MessagesUpdatedState());

      if (response.data.isNotEmpty) {
        conversationId = response.data.first.conversationId.toString();

        _listenForMessages(response.data.first.conversationId.toString());
      }
    } catch (e) {
      emit(GetMessagesFailedState(e.toString()));
      rethrow;
      // TODO
    }
  }

  void _listenForMessages(String conversationId) async {
    logger.w('listening');

    try {
      var pusherService = await PusherChannelService.getInstance;
      var pusher = await pusherService.getClient;
      if (pusher != null) {
        logger.w('connecting');

        if (!pusher.channels
            .containsKey("private-conversation.$conversationId")) {
          pusher.onAuthorizer = _authorize;

          PusherChannel channel = await pusher.subscribe(
            channelName: "private-conversation.$conversationId",
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
          pusher.onAuthorizer = _authorize;

          pusher.getChannel("private-conversation.$conversationId")?.onEvent =
              onEventReceived;
        }
        await pusher.connect();
      }
    } catch (e, s) {
      logger.w(e.toString());
      SentryService.captureException(e, stackTrace: s);
    }
  }

  _authorize(String channelName, String socketId, options) async {
    return {
      "auth":
          "6e531aee4ab45d75d4ad:${getSignature("$socketId:private-conversation.$conversationId")}",
    };
  }

  getSignature(String value) {
    var key = utf8.encode('a7a8a166ad27ac7b03b3');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  FutureOr<void> _mapMessageReceivedEventToState(
      MessageReceivedEvent event, Emitter<SessionChatState> emit) {
    // if (messages.any((element) => element.id != event.message.toString())) {
    //
    // }
    messages.insert(0, event.message);
    emit(MessagesUpdatedState());
    // Debouncer(milliseconds: 300).run(() {
    //
    // });
  }

  onSubscriptionError(message, d) {
    logger.e(message);
  }

  onEventReceived(event) {
    try {
      injector.get<PusherCubit>().triggerPusherEvent(event);

      var receivedEvent = (event as PusherEvent);

      if (receivedEvent.eventName == 'new-message') {
        logger.i('received chat message${receivedEvent.data}');
        // var dataMap = jsonDecode(receivedEvent.data);

        final newMessage =
            NewMeessageResponse.fromJson(jsonDecode(receivedEvent.data));

        if (newMessage.data.isTherapist) {
          logger.i('adding chat message');

          // messages.insert(
          //     0, TherapyChatMessage.fromChatMessage(newMessage.data));

          add(MessageReceivedEvent(
              TherapyChatMessage.fromChatMessage(newMessage.data)));
        }

        logger.i(receivedEvent.data.runtimeType);
      }
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }

  FutureOr<void> _mapRetryMessageEventToState(
      ResendMessageEvent event, Emitter<SessionChatState> emit) async {
    messages
        .where((element) => element.id == event.message.id)
        .first
        .sendingState = SendingState.loading;
    emit(SendMessageLoadingState());
    try {
      final response = await _chatRepository.sendMessage(event.message);

      if (messages.length < 2) {
        conversationId = response.data.conversationId.toString();
        _listenForMessages(response.data.conversationId.toString());
      }

      messages
          .where((element) => element.id == event.message.id)
          .first
          .sendingState = SendingState.success;

      emit(SendMessageSuccesState());
    } catch (e) {
      messages
          .where((element) => element.id == event.message.id)
          .first
          .sendingState = SendingState.failed;
      emit(SendMessageFailedState());
    }
  }
}
