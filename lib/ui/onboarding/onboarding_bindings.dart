import 'package:efood/data/services/local/shared_preferences_service.dart';
import 'package:efood/ui/onboarding/onboarding_viewmodel.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingViewModel>(
      () => OnBoardingViewModel(
        sharedPreferencesService: Get.find<SharedPreferencesService>(),
      ),
    );
  }
}
