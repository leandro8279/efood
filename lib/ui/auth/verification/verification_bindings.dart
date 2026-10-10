import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/auth/verification/verification_viewmodel.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:get/get.dart';

class VerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationViewModel>(
      () => VerificationViewModel(
        authRepository: Get.find<AuthRepository>(),
        configNotifier: Get.find<ConfigNotifier>(),
      ),
    );
  }
}
