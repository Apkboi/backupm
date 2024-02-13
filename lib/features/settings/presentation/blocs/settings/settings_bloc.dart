import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/settings/data/models/update_profile_response.dart';
import 'package:mentra/features/settings/data/models/verify_passcode_response.dart';
import 'package:mentra/features/settings/dormain/repository/settings_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

// Bloc class
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc(this._settingsRepository) : super(SettingsInitial()) {
    on<UpdateProfileEvent>(_mapUpdateProfileEventToState);
    on<VerifyPasscodeEvent>(_mapVerifyPasscodeEventToState);
    on<UpdatePasscodeEvent>(_mapUpdatePasscodeEventToState);
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
}
