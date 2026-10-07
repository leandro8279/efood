import 'dart:async';

import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/auth/auth_session_notifier.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class SplashViewModel extends GetxController {
  SplashViewModel({
    required ConfigRepository configRepository,
    required AuthSessionNotifier authSessionNotifier,
  }) : _configRepository = configRepository,
       _authSessionNotifier = authSessionNotifier;

  final ConfigRepository _configRepository;
  final AuthSessionNotifier _authSessionNotifier;

  late final loadConfig = Command0(_loadConfig);

  Config? get config =>
      loadConfig.complete ? _configRepository.config : null;

  Future<Result<void>> _loadConfig() async {
    final result = await _configRepository.getConfig();

    switch (result) {
      case Ok<Config>():
        return Result.done;
      case Error<Config>(:final error):
        return Result.error(error);
    }
  }

  @override
  void onInit() {
    super.onInit();
    unawaited(_authSessionNotifier.restoreSession());
    loadConfig.execute();
  }
}
