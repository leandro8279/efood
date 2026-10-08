import 'package:efood/data/services/local/shared_preferences_service.dart';
import 'package:efood/data/services/local/storage_keys.dart';
import 'package:efood/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryLocal({required final SharedPreferencesService _sharedPreferencesService})
    implements OnboardingRepository {
  @override
  bool isOnboardingSkipped() {
    return _sharedPreferencesService.getBool(StorageKeys.onBoardingSkip);
  }
}
