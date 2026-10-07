import 'package:efood/data/repositories/auth/auth_repository.dart';
import 'package:efood/data/repositories/auth_session/auth_session_repository.dart';
import 'package:efood/domain/models/auth/auth_session.dart';
import 'package:efood/utils/result.dart';

class AuthLoginUseCase({
  required final AuthRepository _authRepository,
  required final AuthSessionRepository _authSessionRepository,
}) {
  Future<Result<String>> login({required String emailOrPhone, required String type, required String password}) async {
    final authenticated = await _authRepository.login(emailOrPhone: emailOrPhone, type: type, password: password);

    switch (authenticated) {
      case Ok<AuthSession>(value: final session):
        final saved = await _authSessionRepository.save(session.token);

        return switch (saved) {
          Ok<void>() => Result.ok(session.token),
          Error<void>(:final error) => Result.error(error),
        };

      case Error<AuthSession>(:final error):
        return Result.error(error);
    }
  }
}
