import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState>
    implements MesiboConnectionListener, MesiboMessageListener {
  static final Mesibo _mesibo = Mesibo();
  static final MesiboUI _mesiboUi = MesiboUI();
  MesiboProfile? profile;

  SessionBloc() : super(SessionInitial()) {
    on<SessionEvent>((event, emit) {});
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
  }

  @override
  void Mesibo_onConnectionStatus(int status) {
    // TODO: implement Mesibo_onConnectionStatus
  }

  @override
  void Mesibo_onMessage(MesiboMessage message) {}

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
    MesiboProfile profile = await _mesibo.getUserProfile('adga');
    MesiboReadSession session = profile.createReadSession(this);
    await session.read(100);
  }
}
