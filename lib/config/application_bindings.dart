import 'package:dio/dio.dart';
import 'package:efood/core/auth/auth_session_notifier.dart';
import 'package:efood/data/services/api/interceptors/auth_interceptor.dart';
import 'package:get/get.dart';
import 'package:efood/config/environment.dart';
import 'package:efood/data/repositories/splash/splash_repository.dart';
import 'package:efood/data/repositories/splash/splash_repository_remote.dart';
import 'package:efood/data/services/api/splash_api.dart';
import 'package:efood/data/services/local/shared_preferences_service.dart';
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
    Get.put<SplashApi>(SplashApi(Get.find<Dio>()), permanent: true);
    Get.put<SharedPreferencesService>(SharedPreferencesService(sharedPreferences: sharedPreferences), permanent: true);

    // Repositories (registrados pela abstração)
    Get.put<SplashRepository>(
      SplashRepositoryRemote(splashApi: Get.find(), sharedPreferencesService: Get.find()),
      permanent: true,
    );

    // lazy: false,
    Get.put(AuthSessionNotifier(sessionEnded: Get.find<AuthInterceptor>().onUnauthorized));
  }
}
