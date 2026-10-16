import 'package:efood/ui/profile/profile_viewmodel.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileViewModel(authSessionNotifier: Get.find<AuthSessionNotifier>(), configNotifier: Get.find<ConfigNotifier>()));
  }
}
