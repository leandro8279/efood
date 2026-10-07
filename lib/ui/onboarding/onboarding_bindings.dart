import 'package:efood/data/repositories/onboarding/onboarding_repository.dart';
import 'package:efood/data/repositories/onboarding/onboarding_repository_local.dart';
import 'package:efood/data/services/local/local_data_service.dart';
import 'package:efood/data/services/local/shared_preferences_service.dart';
import 'package:efood/ui/onboarding/onboarding_viewmodel.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepositoryLocal(localDataService: Get.find<LocalDataService>()));
    Get.lazyPut<OnBoardingViewModel>(
      () => OnBoardingViewModel(
        onBoradingRepository: Get.find<OnBoardingRepository>(),
        sharedPreferencesService: Get.find<SharedPreferencesService>(),
      ),
    );
  }
}
