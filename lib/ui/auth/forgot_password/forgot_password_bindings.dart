import 'package:efood/ui/auth/forgot_password/forgot_password_viewmodel.dart';
import 'package:get/get.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordViewModel(authRepository: Get.find()));
  }
}
