part of 'user_preference_cubit.dart';

abstract class UserPreferenceState {
  const UserPreferenceState();
}

class UserPreferenceInitial extends UserPreferenceState {
  // @override
  // List<Object> get props => [];
}

class QuestionUpdatedState extends UserPreferenceState {
  // @override
  // List<Object> get props => [];
}

class QuestionsCompletedState extends UserPreferenceState {
  // @override
  // List<Object> get props => [];
}

class UpdatePreferenceLoadingState extends UserPreferenceState {
  // @override
  // List<Object> get props => [];
}

class UpdatePreferenceFailureState extends UserPreferenceState {
  final String error;

  UpdatePreferenceFailureState(this.error);
// @override
// List<Object> get props => [];
}

class UpdatePreferenceSuccessState extends UserPreferenceState {
  final SuccessResponse response;

  UpdatePreferenceSuccessState(this.response);
// @override
// List<Object> get props => [];
}

class RemoveTypingState extends UserPreferenceState {
  RemoveTypingState();
// @override
// List<Object> get props => [];
}
