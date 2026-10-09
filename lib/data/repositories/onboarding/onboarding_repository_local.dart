import 'package:efood/data/services/local/local.dart';
import 'package:efood/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryLocal({required final SharedPreferencesService _sharedPreferencesService})
    implements OnboardingRepository {
  @override
  bool isOnboardingSkipped() {
    return _sharedPreferencesService.getBool(StorageKeys.onBoardingSkip);
  }
}
