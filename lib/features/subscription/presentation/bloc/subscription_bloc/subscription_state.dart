part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
}

class SubscriptionInitial extends SubscriptionState {
  @override
  List<Object> get props => [];
}

class SubscriptionLoadingState extends SubscriptionState {
  @override
  List<Object> get props => [];
}

class SubscriptionFailureState extends SubscriptionState {
  final String error;

  const SubscriptionFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class GetPlansLoadingState extends SubscriptionState {
  @override
  List<Object> get props => [];
}

class GetPlansSuccessState extends SubscriptionState {
  final GetPlansResponse response;

  const GetPlansSuccessState(this.response);

  @override
  List<Object> get props => [];
}

class GetPlansFailureState extends SubscriptionState {
  final String error;

  const GetPlansFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class SubscribeSuccessState extends SubscriptionState {
  final dynamic response;
  // final SubscribeResponse response;

  const SubscribeSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
