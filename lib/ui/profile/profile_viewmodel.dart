import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class ProfileViewModel({required final AuthSessionNotifier _authSessionNotifier, required final ConfigNotifier _configNotifier})
    extends GetxController {
  Rx<Profile?> get profile => _authSessionNotifier.profile;

  Config get config => _configNotifier.config.value!;
  bool get isSignedIn => _authSessionNotifier.isSignedIn.value;

  @override
  void onInit() {
    super.onInit();
    if (_authSessionNotifier.isSignedIn.value) _authSessionNotifier.signedIn();
  }
}
