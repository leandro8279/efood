import 'package:efood/domain/repositories/auth_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/ui/auth/verification/verification_viewmodel.dart';
import 'package:get/get.dart';

class VerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationViewModel>(
      () => VerificationViewModel(
        authRepository: Get.find<AuthRepository>(),
        configRepository: Get.find<ConfigRepository>(),
      ),
    );
  }
}
