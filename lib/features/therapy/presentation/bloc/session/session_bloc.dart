import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/therapy/data/models/chat_message.dart';
import 'package:mentra/features/therapy/presentation/widgets/join_session_button.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

import '../../../../../core/di/injector.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState>
    implements MesiboMessageListener {
  static final Mesibo _mesibo = Mesibo();

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

  @override
  void Mesibo_onMessage(MesiboMessage message) {
    add(MessageReceivedEvent(message));
  }

  @override
  void Mesibo_onMessageStatus(MesiboMessage message) {
    // TODO: implement Mesibo_onMessageStatus
  }

  @override
  void Mesibo_onMessageUpdate(MesiboMessage message) {}

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<SessionState> emit) async {
    MesiboProfile profile = await _mesibo.getUserProfile('adga');
    MesiboMessage m = profile.newMessage();
    m.message = "Hello from Flutter";
    m.send();
  }

  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<SessionState> emit) async {
    _listenForMessages();
  }

  Future<void> _listenForMessages() async {
    Mesibo.getInstance().setListener(this);
    MesiboProfile profile =
        await Mesibo.getInstance().getUserProfile(user2.token);
    var session = profile.createReadSession(this);
    var read = await session.read(10);
    logger.i(await session.getTotalMessageCount());
    MesiboReadSession rs = MesiboReadSession.createReadSummarySession(this);
    rs.read(100);

    // Mesibo.getInstance().

    // sendMessage();
  }

  // void _addMessage(MesiboMessage message) {
  //
  // }

  FutureOr<void> _mapMessageReceivedEventToState(
      MessageReceivedEvent event, Emitter<SessionState> emit) {
    log('message');
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
