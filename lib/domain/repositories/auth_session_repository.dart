import 'package:efood/utils/result.dart';

abstract interface class AuthSessionRepository {
  Future<Result<String?>> readToken();
  Future<Result<void>> save(String token);
  Future<Result<void>> delete();
}
