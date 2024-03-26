part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserCachedState extends UserState {
  final MentraUser user;

  const UserCachedState(this.user);

  @override
  List<Object> get props => [user];
}

// class UserInitial extends UserState {
//   @override
//   List<Object> get props => [];
// }
//
// class UserInitial extends UserState {
//   @override
//   List<Object> get props => [];
// }
