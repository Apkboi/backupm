part of 'pusher_cubit.dart';

@immutable
abstract class PusherState {}

class PusherInitial extends PusherState {}

class PusherEventReceivedState extends PusherState {
  final PusherEvent event;

  PusherEventReceivedState(this.event);
}
