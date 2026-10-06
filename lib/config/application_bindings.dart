import 'package:dio/dio.dart';
import 'package:efood/core/auth/auth_session_notifier.dart';
import 'package:efood/data/repositories/config/config_repository.dart';
import 'package:efood/data/repositories/config/config_repository_remote.dart';
import 'package:efood/data/services/api/interceptors/auth_interceptor.dart';
import 'package:efood/data/services/local/local_data_service.dart';
import 'package:get/get.dart';
import 'package:efood/config/environment.dart';
import 'package:efood/data/repositories/splash/splash_repository.dart';
import 'package:efood/data/repositories/splash/splash_repository_remote.dart';
import 'package:efood/data/services/api/splash_api.dart';
import 'package:efood/data/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationBindings({required final SharedPreferences sharedPreferences}) extends Bindings {
  @override
  void dependencies() {
    // Infraestrutura
    Get.put<AuthInterceptor>(AuthInterceptor(), permanent: true);
    Get.put<Dio>(
      Dio(BaseOptions(baseUrl: Environment.baseUrl))..interceptors.add(Get.find<AuthInterceptor>()),
      permanent: true,
    );

    // Services (primeiro, para serem injetados nos repositories)
    Get.put<LocalDataService>(LocalDataService(), permanent: true);
    Get.put<SplashApi>(SplashApi(Get.find()), permanent: true);
    Get.put<SharedPreferencesService>(SharedPreferencesService(sharedPreferences: sharedPreferences), permanent: true);

    // Repositories (registrados pela abstração)
    Get.put<ConfigRepository>(
      ConfigRepositoryRemote(splashApi: Get.find<SplashApi>()),
      permanent: true,
    );
    Get.put<SplashRepository>(
      SplashRepositoryRemote(splashApi: Get.find(), sharedPreferencesService: Get.find()),
      permanent: true,
    );

    // lazy: false,
    Get.put(AuthSessionNotifier(sessionEnded: Get.find<AuthInterceptor>().onUnauthorized), permanent: true);
  }

  // dentro do AuthSessionNotifier (ou em um listener no main/bindings)
  // @override
  // void onInit() {
  //   super.onInit();

  //   ever<AuthSessionUser?>(_user, (user) {
  //     if (!isRestored) return;
  //     Get.offAllNamed(user == null ? AppRoutes.login : AppRoutes.home);
  //   });
  // }
}
