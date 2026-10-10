import 'dart:async';

import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class ConfigNotifier({required final ConfigRepository _configRepository}) {
  final _log = AppLogger('ConfigNotifier');
  final Rxn<Config> _config = Rxn<Config>();

  Rxn<Config?> get config => _config;
  Config get requireConfig {
    final config = _config.value;
    if (config == null) {
      throw StateError('Config has not been loaded successfully yet.');
    }
    return config;
  }

  this {
    unawaited(_loadConfig());
  }

  Future<Result<void>> _loadConfig() async {
    _log.info('Carregando configuração');
    final result = await _configRepository.getConfig();

    return switch (result) {
      Ok<Config>(:final value) => _setConfig(value),
      Error<Config>(:final error) => _handleLoadError(error),
    };
  }

  Result<void> _setConfig(Config config) {
    _config.value = config;
    _log.info('Configuração carregada com sucesso');
    return Result.done;
  }

  Result<void> _handleLoadError(AppException error) {
    _log.error(
      'Falha ao carregar configuração',
      error: error,
      stackTrace: error.stackTrace,
    );
    return Result.error(error);
  }
}
