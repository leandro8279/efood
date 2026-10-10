import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/auth/signup/signup_viewmodel.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:get/get.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpViewModel>(
      () => SignUpViewModel(authRepository: Get.find<AuthRepository>(), configNotifier: Get.find<ConfigNotifier>()),
    );
  }
}
