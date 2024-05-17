part of 'deep_link_bloc.dart';

abstract class DeepLinkState {
  const DeepLinkState();
}

class DeepLinkInitial extends DeepLinkState {
  @override
  List<Object> get props => [];
}

class NoDeepLink extends DeepLinkState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ActiveDeepLink extends DeepLinkState {
  final dynamic data;

  const ActiveDeepLink(this.data);

  @override
  List<Object?> get props => [];
}
