import 'package:efood/domain/models/auth/auth_session.dart';
import 'package:efood/utils/result.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({String? emailOrPhone, required String type, required String password});
}
