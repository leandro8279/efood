import 'package:efood/domain/models/auth/auth_check_status.dart';
import 'package:efood/domain/repositories/auth_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class VerificationViewModel({
  required final AuthRepository _authRepository,
  required final ConfigRepository _configRepository,
}) extends GetxController {
  final _isEnableVerificationCode = false.obs;
  final _verificationCode = ''.obs;

  late final resendCode = Command1<void, (String, bool)>(_resendCode);

  bool get phoneVerification => _configRepository.config.phoneVerification;
  bool get emailVerification => _configRepository.config.emailVerification;
  bool get isEnableVerificationCode => _isEnableVerificationCode.value;
  String get verificationCode => _verificationCode.value;

  Future<Result<void>> _resendCode((String, bool) request) async {
    final (contact, fromSignUp) = request;

    if (!fromSignUp) {
      return _authRepository.forgetPassword(contact);
    }

    final result = emailVerification
        ? await _authRepository.checkEmail(contact)
        : await _authRepository.checkPhone(contact);

    return switch (result) {
      Ok<AuthCheckStatus>() => Result.done,
      Error<AuthCheckStatus>(:final error) => Result.error(error),
    };
  }

  void updateVerificationCode(String query) {
    _isEnableVerificationCode.value = query.length == 4;
    _verificationCode.value = query;
  }
}
