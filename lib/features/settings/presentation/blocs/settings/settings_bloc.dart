import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/settings/data/models/get_avatars_response.dart';
import 'package:mentra/features/settings/data/models/update_profile_response.dart';
import 'package:mentra/features/settings/data/models/upload_avatar_response.dart';
import 'package:mentra/features/settings/data/models/verify_passcode_response.dart';
import 'package:mentra/features/settings/dormain/repository/settings_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

// Bloc class
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  bool soundEnabled = false;
  bool notificationsEnabled = false;

  SettingsBloc(this._settingsRepository) : super(SettingsInitial()) {
    on<UpdateProfileEvent>(_mapUpdateProfileEventToState);
    on<VerifyPasscodeEvent>(_mapVerifyPasscodeEventToState);
    on<UpdatePasscodeEvent>(_mapUpdatePasscodeEventToState);
    on<GetAvatarsEvent>(_mapGetAvatarsEventToState);
    on<UploadImageEvent>(_mapUploadImageEventToState);
    on<DeleteAccountEvent>(_mapDeleteAccountEventToState);
    on<EraseDataEvent>(_mapEraseDataEventToState);
    on<SwitchSoundEnabledEvent>(_mapSwitchSoundEnabledEventToState);
    on<SwitchNotificationEnabledEvent>(
        _mapSwitchNotificationEnabledEventToState);
  }

  Future<void> _mapUpdateProfileEventToState(
    UpdateProfileEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(UpdateProfileLoadingState());
    try {
      final response = await _settingsRepository.updateProfile(
          name: event.name, birthYear: event.birthYear);
      injector.get<UserBloc>().add(SaveUserEvent(response.data));
      emit(UpdateProfileSuccessState(response: response));
    } catch (e) {
      emit(UpdateProfileFailureState(error: e.toString()));
    }
  }

  Future<void> _mapVerifyPasscodeEventToState(
    VerifyPasscodeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(VerifyPasscodeLoadingState());
    try {
      final response =
          await _settingsRepository.verifyPasscode(passcode: event.passcode);
      emit(VerifyPasscodeSuccessState(response: response));
    } catch (e) {
      emit(VerifyPasscodeFailureState(error: e.toString()));
    }
  }

  Future<void> _mapUpdatePasscodeEventToState(
    UpdatePasscodeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(UpdatePasscodeLoadingState());
    try {
      final response = await _settingsRepository.updatePasscode(
          hash: event.hash,
          passcode: event.passcode,
          passcodeConfirmation: event.passcodeConfirmation);
      emit(UpdatePasscodeSuccessState(response: response));
    } catch (e) {
      emit(UpdatePasscodeFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetAvatarsEventToState(
      GetAvatarsEvent event, Emitter<SettingsState> emit) async {
    emit(GetAvatarsLoadingState());
    try {
      final response = await _settingsRepository.getAvatars();
      emit(GetAvatarsSuccessState(response: response));
    } catch (e, stack) {
      logger.i(e.toString(), stackTrace: stack);
      emit(GetAvatarsFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapUploadImageEventToState(
      UploadImageEvent event, Emitter<SettingsState> emit) async {
    emit(UploadImageLoadingState());
    try {
      final response = await _settingsRepository.uploadAvatar(
          avatarId: event.imageId, bgColor: event.bgColor);
      injector.get<UserBloc>().add(SaveUserEvent(response.data));
      emit(UploadImagesSuccessState(response: response));
    } catch (e) {
      emit(UploadImageFailureState(error: e.toString()));
    }
  }

  Future<void> _mapDeleteAccountEventToState(
    DeleteAccountEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(DeleteAccountLoadingState());
    try {
      // Call repository method to delete account
      final response = await _settingsRepository.deleteAccount(event.reason);
      emit(DeleteAccountSuccessState(response));
    } catch (e) {
      emit(DeleteAccountFailureState(e.toString()));
    }
  }

  Future<void> _mapEraseDataEventToState(
    EraseDataEvent event,
    Emitter<SettingsState> emit,
  ) async {

    emit(EraseDataLoadingState());
    try {
      // Call repository method to erase data
      final response = await _settingsRepository.eraseData();
      emit(EraseDataSuccessState(response));
    } catch (e) {
      emit(EraseDataFailureState(e.toString()));
    }


  }

  FutureOr<void> _mapSwitchSoundEnabledEventToState(
      SwitchSoundEnabledEvent event, Emitter<SettingsState> emit) {
    SessionManager.instance.soundEnabled = event.enabled;
    soundEnabled = event.enabled;
    emit(SoundsSwitchedState(event.enabled));
  }

  FutureOr<void> _mapSwitchNotificationEnabledEventToState(
      SwitchNotificationEnabledEvent event, Emitter<SettingsState> emit) {
    SessionManager.instance.notificationEnabled = event.enabled;
    notificationsEnabled = event.enabled;
    emit(NotificationsSwitchedState(event.enabled));
  }

  init() {
    notificationsEnabled = SessionManager.instance.notificationEnabled;
    soundEnabled = SessionManager.instance.soundEnabled;
  }
}
