import 'package:efood/utils/auth/auth_session_notifier.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(
        configNotifier: Get.find<ConfigNotifier>(),
        authSessionNotifier: Get.find<AuthSessionNotifier>(),
      ),
    );
  }
}
