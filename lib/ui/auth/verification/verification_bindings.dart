import 'package:efood/ui/auth/verification/verification_viewmodel.dart';
import 'package:get/get.dart';

class VerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationViewModel>(() => VerificationViewModel(configRepository: Get.find()));
  }
}
