import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class SplashViewModel({
  required final ConfigNotifier _configNotifier,
  required final AuthSessionNotifier _authSessionNotifier,
}) {
  Rxn<Config?> get config => _configNotifier.config;

  bool get isSignedIn => _authSessionNotifier.isSignedIn.value;
}
