part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class UpdateProfileLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccessState extends SettingsState {
  final UpdateProfileResponse response;

  const UpdateProfileSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class UpdateProfileFailureState extends SettingsState {
  final String error;

  const UpdateProfileFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class VerifyPasscodeLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class VerifyPasscodeSuccessState extends SettingsState {
  final VerifyPasscodeResponse response;

  const VerifyPasscodeSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class VerifyPasscodeFailureState extends SettingsState {
  final String error;

  const VerifyPasscodeFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdatePasscodeLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class UpdatePasscodeSuccessState extends SettingsState {
  final SuccessResponse response;

  const UpdatePasscodeSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class UpdatePasscodeFailureState extends SettingsState {
  final String error;

  const UpdatePasscodeFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetAvatarsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class GetAvatarsSuccessState extends SettingsState {
  final GetAvatarsResponse response;

  const GetAvatarsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetAvatarsFailureState extends SettingsState {
  final String error;

  const GetAvatarsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class UploadImageLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class UploadImagesSuccessState extends SettingsState {
  final UploadAvatarResponse response;

  const UploadImagesSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class UploadImageFailureState extends SettingsState {
  final String error;

  const UploadImageFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class DeleteAccountLoadingState extends SettingsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteAccountSuccessState extends SettingsState {
  final dynamic response;

  const DeleteAccountSuccessState(this.response);

  @override
  List<Object?> get props => [];
}

class DeleteAccountFailureState extends SettingsState {
  final String error;

  DeleteAccountFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class EraseDataLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class EraseDataSuccessState extends SettingsState {
  final dynamic response;

  const EraseDataSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class EraseDataFailureState extends SettingsState {
  final String error;

  const EraseDataFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class NotificationsSwitchedState extends SettingsState {
  final bool enabled;

  const NotificationsSwitchedState(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class SoundsSwitchedState extends SettingsState {
  final bool enabled;

  const SoundsSwitchedState(this.enabled);

  @override
  List<Object?> get props => [enabled];
}
