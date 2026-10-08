import 'package:efood/domain/repositories/config_repository.dart';
import 'package:get/get.dart';

class VerificationViewModel({required final ConfigRepository _configRepository}) extends GetxController {
  bool get phoneVerification => _configRepository.config.phoneVerification;
  bool get emailVerification => _configRepository.config.emailVerification;

  void updateVerificationCode(String? value) {}
}
