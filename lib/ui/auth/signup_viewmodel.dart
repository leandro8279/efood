import 'package:efood/domain/models/auth/auth_check_email.dart';
import 'package:efood/domain/repositories/auth_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class SignUpViewModel({
  required final AuthRepository _authRepository,
  required final ConfigRepository _configRepository,
}) extends GetxController {
  late final checkEmail = Command1<AuthCheckEmail, String>(_checkEmail);

  bool get emailVerification => _configRepository.config.emailVerification;

  Future<Result<AuthCheckEmail>> _checkEmail(String email) {
    return _authRepository.checkEmail(email);
  }
}
