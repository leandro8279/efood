import 'package:efood/data/repositories/config/config_repository.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:get/get.dart';

class LoginViewModel({required final ConfigRepository _configRepository}) extends GetxController {
  final _isActiveRememberMe = false.obs;

  Config? get config => _configRepository.config;
  bool get isActiveRememberMe => _isActiveRememberMe.value;

  void toggleRememberMe() {
    _isActiveRememberMe.value = !_isActiveRememberMe.value;
  }
}
