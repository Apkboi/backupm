part of 'call_cubit.dart';

abstract class CallState {
  const CallState();
}

class CallInitial extends CallState {
  @override
  List<Object> get props => [];
}

class CallStateUpdated extends CallState {
  @override
  List<Object> get props => [];
}

// class CallStateUpdated extends CallState {
//   @override
//   List<Object> get props => [];
// }

class CallConnectingState extends CallState {
  @override
  List<Object> get props => [];
}

class CallConnectingFailedState extends CallState {
  @override
  List<Object> get props => [];
}

class CallConnectedState extends CallState {
  @override
  List<Object> get props => [];
}

class AcceptCallState extends CallState {
  final String callerId;

  AcceptCallState(this.callerId);

  List<Object> get props => [callerId];
}

class CallEndedState extends CallState {
  CallEndedState();

  List<Object> get props => [];
}

class EndCallLoadingState extends CallState {
  EndCallLoadingState();

  List<Object> get props => [];
}


class CallActionState extends CallState {
  final IncomingCallResponse response;

  CallActionState(this.response);

  List<Object> get props => [response];
}
