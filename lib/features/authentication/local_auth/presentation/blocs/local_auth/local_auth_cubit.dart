import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/biometric/biometric_service.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/utils/extensions/dartz_extension.dart';

part 'local_auth_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  LocalAuthCubit() : super(LocalAuthInitial());

  // final PinStorage storage = PinStorage();
  bool biometricEnabled = false;

  Future<void> enableBiometric() async {
    var result =
        await injector.get<BiometricService>().authenticateWithBiometric();
    logger.i(result.isLeft);
    if (result.isLeft) {
      emit(BiometricEnableFailedState(result.asLeft()));
    } else {
      if (result.asRight()) {
        SessionManager.instance.bioMetricEnabled = true;
        biometricEnabled = true;
        emit(const BiometricEnabledState());
      } else {
        emit(const BiometricEnableFailedState('Authentication failed'));
      }
    }
  }

  void disableBiometric() {
    SessionManager.instance.bioMetricEnabled = false;
    biometricEnabled = false;
    emit(const BiometricDisabledState());
  }

  Future<bool> authenticateUser() async {
    var result =
        await injector.get<BiometricService>().authenticateWithBiometric();
    if (result.isLeft) {
      return false;
    } else {
      if (result.asRight()) {
        return true;
      } else {
        return false;
      }
    }
  }

  void init() {
    biometricEnabled = SessionManager.instance.bioMetricEnabled;
  }
}
