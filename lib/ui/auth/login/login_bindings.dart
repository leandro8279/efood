import 'package:efood/utils/auth/auth_session_notifier.dart';
import 'package:efood/domain/use_cases/auth/auth_login_use_case.dart';
import 'package:efood/ui/auth/login/login_viewmodel.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthLoginUseCase(authRepository: Get.find(), authSessionRepository: Get.find()));
    Get.lazyPut<LoginViewModel>(
      () => LoginViewModel(
        configRepository: Get.find(),
        loginUseCase: Get.find(),
        sessionNotifier: Get.find<AuthSessionNotifier>(),
      ),
    );
  }
}
