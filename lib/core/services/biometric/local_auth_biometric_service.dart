import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'package:local_auth/local_auth.dart';

import 'biometric_service.dart';

class LocalAuthBiometricService extends BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Future<Either<String, bool>> authenticateWithBiometric() async {
    bool canAuthenticateUser = await canAuthenticate();

    if (canAuthenticateUser) {
      try {
        final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate');
        return Right(didAuthenticate);
      } on PlatformException catch (e) {
        String error = 'An error occured';
        if (e.code == auth_error.notAvailable) {
          error = 'Fingerprint not available!';
          // Add handling of no hardware here.
        } else if (e.code == auth_error.notEnrolled) {
          error = 'Fingerprint not enrolled!';
        } else {
          error = e.message.toString();
        }
        return Left(e.code.toString());
      }
    }
    return const Left('Biometric not available on device');
  }

  @override
  Future<bool> canAuthenticate() async {
    await auth.getAvailableBiometrics();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate && canAuthenticateWithBiometrics;
  }
}
