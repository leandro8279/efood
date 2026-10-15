import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/menu/menu_viewmodel.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class MenuBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MenuViewModel(
        configNotifier: Get.find<ConfigNotifier>(),
        splashRepository: Get.find<SplashRepository>(),
        authSessionNotifier: Get.find<AuthSessionNotifier>(),
      ),
    );
  }
}
