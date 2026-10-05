import 'package:efood/data/repositories/splash/splash_repository.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(splashRepository: Get.find<SplashRepository>()),
    );
  }
}
