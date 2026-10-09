import 'package:efood/domain/repositories/repositórios.dart';
import 'package:efood/ui/auth/register/register_viewmodel.dart';
import 'package:get/get.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterViewModel>(
      () => RegisterViewModel(
        authRepository: Get.find<AuthRepository>(),
        configRepository: Get.find<ConfigRepository>(),
      ),
    );
  }
}
