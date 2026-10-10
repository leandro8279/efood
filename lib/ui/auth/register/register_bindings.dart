import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/auth/register/register_viewmodel.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:get/get.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterViewModel>(
      () =>
          RegisterViewModel(authRepository: Get.find<AuthRepository>(), configNotifier: Get.find<ConfigNotifier>()),
    );
  }
}
