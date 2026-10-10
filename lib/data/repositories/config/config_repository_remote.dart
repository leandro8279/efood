import 'package:dio/dio.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/splash_api.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/result.dart';

class ConfigRepositoryRemote({required final SplashApi _splashApi}) implements ConfigRepository {
  Config? _cachedConfig;
  Future<Result<Config>>? _configRequest;

  @override
  Config get config {
    final cachedConfig = _cachedConfig;
    if (cachedConfig == null) {
      throw StateError('Config has not been loaded successfully yet.');
    }
    return cachedConfig;
  }

  @override
  Future<Result<Config>> getConfig() {
    final cachedConfig = _cachedConfig;
    if (cachedConfig != null) {
      return Future<Result<Config>>.value(Result.ok(cachedConfig));
    }

    final requestInProgress = _configRequest;
    if (requestInProgress != null) {
      return requestInProgress;
    }

    final request = _fetchConfig();
    _configRequest = request;
    return request;
  }

  Future<Result<Config>> _fetchConfig() async {
    try {
      final apiModel = await _splashApi.getConfig();
      final config = apiModel.toDomain();

      _cachedConfig = config;
      return Result.ok(config);
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    } finally {
      _configRequest = null;
    }
  }
}
