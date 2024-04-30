part of 'call_cubit.dart';


abstract class CallState  {
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


