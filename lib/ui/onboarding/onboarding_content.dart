import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/onboarding/onboarding_slide.dart';

abstract final class OnboardingContent {
  static final List<OnboardingSlide> slides = List<OnboardingSlide>.unmodifiable([
    OnboardingSlide(
      imageAsset: AppAssets.images.onboardingOne,
      titleKey: 'make_your_choice_order',
      descriptionKey: 'you_can_choice_the_best',
    ),
    OnboardingSlide(
      imageAsset: AppAssets.images.onboardingTwo,
      titleKey: 'select_delivery_location',
      descriptionKey: 'select_accurate_location',
    ),
    OnboardingSlide(
      imageAsset: AppAssets.images.onboardingThree,
      titleKey: 'delivery_to_your_home',
      descriptionKey: 'get_food_delivery_at_home',
    ),
  ]);
}
