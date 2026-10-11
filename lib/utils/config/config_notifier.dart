import 'dart:async';

import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class ConfigNotifier({required final ConfigRepository _configRepository}) extends GetxController {
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

  bool isRestaurantOpenNow() {
    final config = _config.value;
    if (config == null) {
      return false;
    }

    final now = DateTime.now();
    if (_isRestaurantClosedOn(config, now)) {
      return false;
    }

    final weekday = now.weekday % 7;
    return config.restaurantScheduleTime.any(
      (schedule) =>
          schedule.day == weekday &&
          DateConverter.isAvailable(
            start: schedule.openingTime,
            end: schedule.closingTime,
            time: now,
          ),
    );
  }

  bool isRestaurantClosed(bool today) {
    final config = _config.value;
    if (config == null) {
      return true;
    }

    final date = DateTime.now().add(today ? Duration.zero : const Duration(days: 1));
    return _isRestaurantClosedOn(config, date);
  }

  bool _isRestaurantClosedOn(Config config, DateTime date) {
    final weekday = date.weekday % 7;
    return !config.restaurantScheduleTime.any((schedule) => schedule.day == weekday);
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
    _log.error('Falha ao carregar configuração', error: error, stackTrace: error.stackTrace);
    return Result.error(error);
  }

  @override
  void onInit() {
    _loadConfig();
    super.onInit();
  }
}
