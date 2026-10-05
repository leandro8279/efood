import 'package:efood/data/repositories/onboarding/onboarding_repository.dart';
import 'package:efood/data/services/local/local_data_service.dart';
import 'package:efood/domain/models/onboarding/onboarding.dart';

import 'package:efood/utils/result.dart';

class OnBoardingRepositoryLocal({required final LocalDataService _localDataService}) implements OnBoardingRepository {
  @override
  Future<Result<List<OnBoarding>>> getOnBoardingList() async {
    final onBoardings = _localDataService.getOnBoardings();

    return Future.value(Result.ok(onBoardings));
  }
}
