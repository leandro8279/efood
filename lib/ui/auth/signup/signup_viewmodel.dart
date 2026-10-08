import 'package:efood/domain/models/auth/auth_check_status.dart';
import 'package:efood/domain/repositories/auth_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class SignUpViewModel({
  required final AuthRepository _authRepository,
  required final ConfigRepository _configRepository,
}) extends GetxController {
  late final checkEmail = Command1<AuthCheckStatus, String>(_checkEmail);
  late final checkPhone = Command1<AuthCheckStatus, String>(_checkPhone);

  bool get emailVerification => _configRepository.config.emailVerification;

  Future<Result<AuthCheckStatus>> _checkEmail(String email) {
    return _authRepository.checkEmail(email);
  }

  Future<Result<AuthCheckStatus>> _checkPhone(String phone) {
    return _authRepository.checkPhone(phone);
  }
}
