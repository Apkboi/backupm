import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/therapy/data/models/chat_message.dart';
import 'package:mentra/features/therapy/presentation/widgets/join_session_button.dart';


part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState>
{

  // static final MesiboUI _mesiboUi = MesiboUI();
  // MesiboProfile? profile;
  List<TherapyChatMessage> messages = [];
  DemoUser user2 = DemoUser(
      '72907e6a689c61c1d5f1572ff97116a28dee3e911a5c673d234eee4ad2f6ja9a4a4cd39a',
      'joel@gmail.com');

  SessionBloc() : super(SessionInitial()) {
    on<SessionEvent>((event, emit) {});
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
    on<MessageReceivedEvent>(_mapMessageReceivedEventToState);
  }



  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<SessionState> emit) async {


  }

  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<SessionState> emit) async {
    _listenForMessages();
  }

  Future<void> _listenForMessages() async {

    // Mesibo.getInstance().

    // sendMessage();
  }

  // void _addMessage(MesiboMessage message) {
  //
  // }

  FutureOr<void> _mapMessageReceivedEventToState(
      MessageReceivedEvent event, Emitter<SessionState> emit) {
    if (messages
        .any((element) => element.id != event.message.refid.toString())) {
      messages.add(TherapyChatMessage(
          message: event.message.message.toString(),
          time: DateTime.now(),
          isTherapist: !(event.message.profile?.selfProfile ?? true),
          id: event.message.refid.toString()));
      emit(MessagesFetchedEvent());
    }
  }
}
