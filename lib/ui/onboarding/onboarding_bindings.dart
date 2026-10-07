import 'package:efood/domain/repositories/onboarding_repository.dart';
import 'package:efood/ui/onboarding/onboarding_viewmodel.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingViewModel>(
      () => OnBoardingViewModel(
        onboardingRepository: Get.find<OnboardingRepository>(),
      ),
    );
  }
}
