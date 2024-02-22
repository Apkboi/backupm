import 'package:mentra/features/account/data/model/account_response.dart';

abstract class AccountRepository {
  Future<AccountResponse> getRemoteUser();
}
