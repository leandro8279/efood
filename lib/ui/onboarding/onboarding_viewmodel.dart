import 'package:efood/domain/repositories/onboarding_repository.dart';
import 'package:get/get.dart';
import 'package:efood/ui/onboarding/onboarding_content.dart';
import 'package:efood/ui/onboarding/onboarding_slide.dart';

class OnBoardingViewModel({required final OnboardingRepository _onboardingRepository}) extends GetxController {
  final _selectedIndex = 0.obs;
  final _showOnBoardingStatus = false.obs;
  final List<OnboardingSlide> _onBoardings = OnboardingContent.slides;

  int get selectedIndex => _selectedIndex.value;
  List<OnboardingSlide> get onBoardings => _onBoardings;
  OnboardingSlide get currentSlide => _onBoardings[_selectedIndex.value];
  bool get showOnBoardingStatus => _showOnBoardingStatus.value;

  void _loadShowOnBoardingStatus() {
    _showOnBoardingStatus.value = _onboardingRepository.isOnboardingSkipped() || true;
  }

  void changeSelectIndex(int index) {
    _selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    _loadShowOnBoardingStatus();
  }
}
