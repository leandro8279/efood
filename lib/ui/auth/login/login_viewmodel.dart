import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/domain/use_cases/auth/auth_login_use_case.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class LoginViewModel({required final ConfigRepository _configRepository, required final AuthLoginUseCase _loginUseCase})
    extends GetxController {
  final _log = AppLogger('LoginViewModel');
  late final login = Command1<void, (String, String)>(_login);

  final _isActiveRememberMe = false.obs;

  Config? get config => _configRepository.config;
  bool get isActiveRememberMe => _isActiveRememberMe.value;

  void toggleRememberMe() {
    _isActiveRememberMe.value = !_isActiveRememberMe.value;
  }

  Future<Result<void>> _login((String, String) credentials) async {
    final (emailOrPhone, password) = credentials;
    final type = _configRepository.config.emailVerification ? "email" : "phone";
    final result = await _loginUseCase.login(type: type, emailOrPhone: emailOrPhone, password: password);

    switch (result) {
      case Ok<String>(:final value):
        _log.info("RESULT $value");
        // _sessionNotifier.signedIn(value);
        return Result.done;
      case Error<String>(:final error):
        _log.error('Falha ao entrar', error: error, stackTrace: error.stackTrace);
        return Result.error(error);
    }
  }
}
