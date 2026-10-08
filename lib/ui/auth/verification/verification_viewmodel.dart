import 'package:efood/domain/repositories/config_repository.dart';
import 'package:get/get.dart';

class VerificationViewModel({required final ConfigRepository _configRepository}) extends GetxController {
  final _isEnableVerificationCode = false.obs;
  final _verificationCode = ''.obs;

  bool get phoneVerification => _configRepository.config.phoneVerification;
  bool get emailVerification => _configRepository.config.emailVerification;
  bool get isEnableVerificationCode => _isEnableVerificationCode.value;
  String get verificationCode => _verificationCode.value;

  void updateVerificationCode(String query) {
    _isEnableVerificationCode.value = query.length == 4;
    _verificationCode.value = query;
  }
}
