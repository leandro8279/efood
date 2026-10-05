import 'package:dio/dio.dart';
import 'package:efood/data/repositories/splash/splash_repository.dart';
import 'package:efood/data/services/api/mappers/config_api_model_mapper.dart';
import 'package:efood/data/services/api/mappers/dio_exception_mapper.dart';
import 'package:efood/data/services/api/splash_api.dart';
import 'package:efood/data/services/local/shared_preferences_service.dart';
import 'package:efood/data/services/local/storage_keys.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';

class const SplashRepositoryRemote({
  required final SplashApi _splashApi,
  required final SharedPreferencesService _sharedPreferencesService,
}) implements SplashRepository {
  @override
  Future<Result<Config>> getConfig() async {
    try {
      final config = await _splashApi.getConfig();
      return Result.ok(config.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<String>> getPolicyPage() async {
    try {
      final policyPage = await _splashApi.getPolicyPage();

      return Result.ok(policyPage);
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<void>> initSharedData() async {
    try {
      if (!_sharedPreferencesService.contains(StorageKeys.theme)) {
        await _sharedPreferencesService.setBool(StorageKeys.theme, false);
      }
      if (!_sharedPreferencesService.contains(StorageKeys.countryCode)) {
        // await _sharedPreferencesService.setString(
        //   StorageKeys.countryCode,
        //   AppConstants.languages[0].countryCode,
        // );
      }
      if (!_sharedPreferencesService.contains(StorageKeys.languageCode)) {
        // await _sharedPreferencesService.setString(
        //   StorageKeys.countryCode,
        //   AppConstants.languages[0].languageCode,
        // );
      }
      if (!_sharedPreferencesService.contains(StorageKeys.onBoardingSkip)) {
        // await _sharedPreferencesService.setBool(
        //   StorageKeys.onBoardingSkip,
        //   true,
        // );
      }
      if (!_sharedPreferencesService.contains(StorageKeys.cartList)) {
        await _sharedPreferencesService.setStringList(StorageKeys.cartList, []);
      }
      return const Result.ok(null);
    } on StorageException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> removeSharedData() async {
    try {
      await _sharedPreferencesService.clear();
      return const Result.ok(null);
    } on StorageException catch (e) {
      return Result.error(e);
    }
  }
}
