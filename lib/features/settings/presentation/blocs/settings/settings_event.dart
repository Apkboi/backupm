part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class UpdateProfileEvent extends SettingsEvent {
  final String name;
  final int birthYear;

  @override
  List<Object?> get props => [name, birthYear];

  const UpdateProfileEvent(this.name, this.birthYear);
}

class VerifyPasscodeEvent extends SettingsEvent {
  final String passcode;

  VerifyPasscodeEvent({required this.passcode});

  @override
  List<Object?> get props => [passcode];
}

class UpdatePasscodeEvent extends SettingsEvent {
  final String hash;
  final String passcode;
  final String passcodeConfirmation;

  const UpdatePasscodeEvent(
      {required this.hash,
      required this.passcode,
      required this.passcodeConfirmation});

  @override
  List<Object?> get props => [hash, passcode, passcodeConfirmation];
}

class GetAvatarsEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class UploadImageEvent extends SettingsEvent {
  final int? imageId;
  final String bgColor;

  const UploadImageEvent(this.imageId, this.bgColor);

  @override
  List<Object?> get props => [imageId, bgColor];
}
