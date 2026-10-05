import 'package:efood/domain/models/onboarding/onboarding.dart';
import 'package:efood/ui/core/share/app_assets.dart';
import 'package:get/get.dart';

class LocalDataService {
  List<OnBoarding> getOnBoardings() {
    return [
      OnBoarding(
        imageUrl: AppAssets.images.onboardingOne,
        title: 'make_your_choice_order'.tr,
        description: 'you_can_choice_the_best'.tr,
      ),
      OnBoarding(
        imageUrl: AppAssets.images.onboardingTwo,
        title: 'select_delivery_location'.tr,
        description: 'select_accurate_location'.tr,
      ),
      OnBoarding(
        imageUrl: AppAssets.images.onboardingThree,
        title: 'delivery_to_your_home'.tr,
        description: 'get_food_delivery_at_home'.tr,
      ),
    ];
  }
}
