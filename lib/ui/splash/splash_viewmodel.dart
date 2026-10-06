import 'package:efood/data/repositories/splash/splash_repository.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class SplashViewModel({required final SplashRepository _splashRepository}) extends GetxController {
  final Rx<Config?> _config = Rx<Config?>(null);

  late final loadConfig = Command0(_loadConfig);

  Config? get config => _config.value;

  Future<Result<void>> _loadConfig() async {
    final result = await _splashRepository.getConfig();

    switch (result) {
      case Ok<Config>(:final value):
        _config.value = value;

        return Result.done;
      case Error<Config>(:final error):
        return Result.error(error);
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadConfig.execute();
  }
}
