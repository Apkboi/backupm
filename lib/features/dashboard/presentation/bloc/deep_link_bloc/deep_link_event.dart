part of 'deep_link_bloc.dart';

abstract class DeepLinkEvent {
  const DeepLinkEvent();
}

class DeepLinkReceived extends DeepLinkEvent {
  final dynamic deepLink;

  const DeepLinkReceived(this.deepLink);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeepLinkCleared extends DeepLinkEvent {
  @override
  List<Object?> get props => [];
}

class CheckForDeepLink extends DeepLinkEvent {
  @override
  List<Object?> get props => [];
}
