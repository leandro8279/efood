import 'package:efood/ui/splash/splash_viewmodel.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(() => SplashViewModel(splashRepository: Get.find()));
  }
}
