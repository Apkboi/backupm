part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
}

class GetPlansEvent extends SubscriptionEvent {
  @override
  List<Object?> get props => [];
}

class CancelSubscriptionEvent extends SubscriptionEvent {
  String id;

  CancelSubscriptionEvent(this.id);

  @override
  List<Object?> get props => [];
}

class SubscribeEvent extends SubscriptionEvent {
  final SubscriptionPayload payload;

  @override
  List<Object?> get props => [payload];

  const SubscribeEvent(this.payload);
}
