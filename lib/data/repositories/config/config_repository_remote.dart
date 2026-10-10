import 'package:dio/dio.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/splash_api.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/result.dart';

class ConfigRepositoryRemote({required final SplashApi _splashApi}) implements ConfigRepository {
  @override
  Future<Result<Config>> getConfig() async {
    try {
      final apiModel = await _splashApi.getConfig();
      final config = apiModel.toDomain();

      return Result.ok(config);
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
