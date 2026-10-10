import 'dart:async';

import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/auth/auth_session_notifier.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:get/get.dart';

class SplashViewModel({
  required final ConfigNotifier _configNotifier,
  required final AuthSessionNotifier _authSessionNotifier,
}) extends GetxController {
  Rxn<Config?> get config => _configNotifier.config;

  @override
  void onInit() {
    super.onInit();
    unawaited(_authSessionNotifier.restoreSession());
  }
}
