import 'package:efood/ui/auth/login/login_viewmodel.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel(splashRepository: Get.find()));
  }
}
