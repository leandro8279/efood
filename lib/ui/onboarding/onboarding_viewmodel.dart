import 'package:efood/config/constants.dart';
import 'package:efood/core/logging/app_logger.dart';
import 'package:efood/data/services/shared_preferences_service.dart';
import 'package:efood/domain/models/onboarding/onboarding.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';
import "package:efood/data/repositories/onboarding/onboarding_repository.dart";

class OnBoardingViewModel({
  required final OnBoardingRepository _onBoradingRepository,
  required final SharedPreferencesService _sharedPreferencesService,
}) extends GetxController {
  final _log = AppLogger('OnBoardingViewModel');

  this {
    _loadShowOnBoardingStatus();
    _log.info("OnBoardingViewModel");
  }

  late final loadOnBoadings = Command0(_load);

  final _selectedIndex = 0.obs;
  final _showOnBoardingStatus = false.obs;
  final _onBoardings = RxList<OnBoarding>([]);

  int get selectedIndex => _selectedIndex.value;
  List<OnBoarding> get onBoardings => _onBoardings;
  bool get showOnBoardingStatus => _showOnBoardingStatus.value;

  void _loadShowOnBoardingStatus() async {
    _showOnBoardingStatus.value = _sharedPreferencesService.getBool(AppConstants.onBoardingSkip) || true;
  }

  Future<Result<void>> _load() async {
    final onBoardings = await _onBoradingRepository.getOnBoardingList();

    switch (onBoardings) {
      case Ok<List<OnBoarding>>(:final value):
        _onBoardings.value = value;
        _log.debug('${value.length} integrações');
        return Result.done;
      case Error<List<OnBoarding>>(:final error):
        _log.error('Falha ao carregar as integrações', error: error, stackTrace: error.stackTrace);
        return Result.error(error);
    }
  }

  void changeSelectIndex(int index) {
    _selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    loadOnBoadings.execute();
  }
}
