import 'package:either_dart/either.dart';

abstract class BiometricService {
  Future<bool> canAuthenticate();
  Future<Either<String, bool>> authenticateWithBiometric();

}
