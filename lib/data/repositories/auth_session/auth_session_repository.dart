import 'package:efood/utils/result.dart';

abstract interface class AuthSessionRepository {
  Future<Result<void>> save(String token);
  Future<Result<void>> delete();
  // Future<Result<AuthSession?>> fetch();
}
