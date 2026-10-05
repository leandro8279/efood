import 'package:efood/domain/models/onboarding/onboarding.dart';
import 'package:efood/utils/result.dart';

abstract class OnBoardingRepository {
  Future<Result<List<OnBoarding>>> getOnBoardingList();
}
