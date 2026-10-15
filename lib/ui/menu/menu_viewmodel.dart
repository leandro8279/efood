import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/config/policy.dart';
import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/domain/repositories/splash_repository.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class MenuViewModel({
  required final ConfigNotifier _configNotifier,
  required final SplashRepository _splashRepository,
  required final AuthSessionNotifier _authSessionNotifier,
}) extends GetxController {
  final Rx<Policy?> _policy = Rx<Policy?>(null);

  Policy? get policy => _policy.value;
  Config get config => _configNotifier.config.value!;
  Profile? get profile => _authSessionNotifier.profile.value;
  bool get isSignedIn => _authSessionNotifier.isSignedIn.value;
}
