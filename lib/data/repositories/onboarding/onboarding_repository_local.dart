import 'package:efood/data/services/local/shared_preferences_service.dart';
import 'package:efood/data/services/local/storage_keys.dart';
import 'package:efood/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryLocal implements OnboardingRepository {
  OnboardingRepositoryLocal({required SharedPreferencesService sharedPreferencesService})
    : _sharedPreferencesService = sharedPreferencesService;

  final SharedPreferencesService _sharedPreferencesService;

  @override
  bool isOnboardingSkipped() {
    return _sharedPreferencesService.getBool(StorageKeys.onBoardingSkip);
  }
}
