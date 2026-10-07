import 'package:efood/config/constants.dart';
import 'package:efood/data/services/local/shared_preferences_service.dart';
import 'package:get/get.dart';
import 'package:efood/ui/onboarding/onboarding_content.dart';
import 'package:efood/ui/onboarding/onboarding_slide.dart';

class OnBoardingViewModel({
  required final SharedPreferencesService _sharedPreferencesService,
}) extends GetxController {
  this {
    _loadShowOnBoardingStatus();
  }

  final _selectedIndex = 0.obs;
  final _showOnBoardingStatus = false.obs;
  final List<OnboardingSlide> _onBoardings = OnboardingContent.slides;

  int get selectedIndex => _selectedIndex.value;
  List<OnboardingSlide> get onBoardings => _onBoardings;
  OnboardingSlide get currentSlide => _onBoardings[_selectedIndex.value];
  bool get showOnBoardingStatus => _showOnBoardingStatus.value;

  void _loadShowOnBoardingStatus() async {
    _showOnBoardingStatus.value = _sharedPreferencesService.getBool(AppConstants.onBoardingSkip) || true;
  }

  void changeSelectIndex(int index) {
    _selectedIndex.value = index;
  }
}
