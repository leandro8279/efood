import 'package:efood/domain/models/auth/auth_check_status.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class VerificationViewModel({
  required final AuthRepository _authRepository,
  required final ConfigNotifier _configNotifier,
}) extends GetxController {
  final _isEnableVerificationCode = false.obs;
  final _verificationCode = ''.obs;

  late final resendCode = Command1<void, (String, bool)>(_resendCode);
  late final verifyCode = Command1<void, (String, String)>(_verifyCode);

  bool get phoneVerification => _configNotifier.requireConfig.phoneVerification;
  bool get emailVerification => _configNotifier.requireConfig.emailVerification;
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

  Future<Result<void>> _verifyCode((String, String) request) {
    final (contact, token) = request;

    return emailVerification
        ? _authRepository.verifyEmail(email: contact, token: token)
        : _authRepository.verifyPhone(phone: contact, token: token);
  }

  void updateVerificationCode(String query) {
    _isEnableVerificationCode.value = query.length == 4;
    _verificationCode.value = query;
  }
}
