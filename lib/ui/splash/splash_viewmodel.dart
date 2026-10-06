import 'package:efood/data/repositories/splash/splash_repository.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class SplashViewModel({required final SplashRepository _splashRepository}) extends GetxController {
  final Rx<Config?> _config = Rx<Config?>(null);

  late final loadOnConfig = Command0(_loadConfig);

  Config? get config => _config.value;

  Future<Result<void>> _loadConfig() async {
    final config = await _splashRepository.getConfig();
    print(config);
    switch (config) {
      case Ok<Config>(:final value):
        _config.value = value;
        return Result.done;
      case Error<Config>(:final error):
        return Result.error(error);
    }
  }

  @override
  void onInit() {
    loadOnConfig.execute();
    super.onInit();
    print("loadOnConfig");
  }
}
