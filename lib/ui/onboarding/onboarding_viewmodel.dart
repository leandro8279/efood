import 'package:efood/config/constants.dart';
import 'package:efood/core/logging/app_logger.dart';
import 'package:efood/data/services/local/shared_preferences_service.dart';
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
        _log.debug('${_onBoardings.length} integrações');
        _log.info("TESTE ${onBoardings.value}");
        return Result.done;
      case Error<List<OnBoarding>>(:final error):
        _log.error('Falha ao carregar as integrações', error: error, stackTrace: error.stackTrace);
        return Result.error(error);
    }
  }

  void changeSelectIndex(int index) {
    _selectedIndex.value = index;
  }

  String get title {
    if (_onBoardings.isEmpty) return "";

    if (_selectedIndex.value == 0) return _onBoardings[0].title;

    if (_selectedIndex.value == 1) return _onBoardings[1].title;

    return _onBoardings[2].title;
  }

  String get description {
    if (_onBoardings.isEmpty) return "";

    if (_selectedIndex.value == 0) return _onBoardings[0].description;

    if (_selectedIndex.value == 1) return _onBoardings[1].description;

    return _onBoardings[2].description;
  }

  @override
  void onInit() {
    loadOnBoadings.execute();
    super.onInit();
  }
}
