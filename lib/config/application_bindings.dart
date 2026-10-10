import 'package:dio/dio.dart';
import 'package:efood/utils/auth/auth_session_notifier.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:efood/data/repositories/auth/auth_repository_remote.dart';
import 'package:efood/data/repositories/auth_session/auth_session_repository_local.dart';
import 'package:efood/data/repositories/cart/cart_repository_local.dart';
import 'package:efood/data/repositories/category/category_repository_remote.dart';
import 'package:efood/data/repositories/config/config_repository_remote.dart';
import 'package:efood/data/repositories/onboarding/onboarding_repository_local.dart';
import 'package:efood/data/repositories/profile/profile_repository_remote.dart';
import 'package:efood/data/repositories/set_menu/set_menu_repository_remote.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/data/services/api/api.dart';
import 'package:efood/data/services/local/local.dart';
import 'package:get/get.dart';
import 'package:efood/config/environment.dart';
import 'package:efood/data/repositories/splash/splash_repository_remote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationBindings({required final SharedPreferences sharedPreferences}) extends Bindings {
  @override
  void dependencies() {
    // Local services and session storage
    Get.put<SharedPreferencesService>(SharedPreferencesService(sharedPreferences: sharedPreferences), permanent: true);
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<AuthSessionRepository>(
      AuthSessionRepositoryLocal(storage: Get.find<SecureStorageService>()),
      permanent: true,
    );

    // Authenticated HTTP client
    Get.put<AuthInterceptor>(
      AuthInterceptor(authSessionRepository: Get.find<AuthSessionRepository>()),
      permanent: true,
    );
    Get.put<Dio>(
      Dio(BaseOptions(baseUrl: Environment.baseUrl)),
      // ..interceptors.add(Get.find<AuthInterceptor>()),
      permanent: true,
    );

    // Services (primeiro, para serem injetados nos repositories)
    Get.put<AuthApi>(AuthApi(Get.find()), permanent: true);
    Get.put<CategoryApi>(CategoryApi(Get.find()), permanent: true);
    Get.put<SetMenuApi>(SetMenuApi(Get.find()), permanent: true);
    Get.put<ProfileApi>(ProfileApi(Get.find()), permanent: true);
    Get.put<SplashApi>(SplashApi(Get.find()), permanent: true);
    Get.put<OnboardingRepository>(
      OnboardingRepositoryLocal(sharedPreferencesService: Get.find<SharedPreferencesService>()),
      permanent: true,
    );
    // Repositories (registrados pela abstração)
    Get.put<CartRepository>(
      CartRepositoryLocal(sharedPreferencesService: Get.find<SharedPreferencesService>()),
      permanent: true,
    );
    Get.put<ConfigRepository>(ConfigRepositoryRemote(splashApi: Get.find<SplashApi>()), permanent: true);
    Get.put<ConfigNotifier>(ConfigNotifier(configRepository: Get.find<ConfigRepository>()), permanent: true);
    Get.put<CategoryRepository>(CategoryRepositoryRemote(categoryApi: Get.find<CategoryApi>()), permanent: true);
    Get.put<SetMenuRepository>(SetMenuRepositoryRemote(setMenuApi: Get.find<SetMenuApi>()), permanent: true);
    Get.put<SplashRepository>(
      SplashRepositoryRemote(splashApi: Get.find(), sharedPreferencesService: Get.find()),
      permanent: true,
    );
    Get.put<ProfileRepository>(ProfileRepositoryRemote(profileApi: Get.find<ProfileApi>()), permanent: true);
    Get.put<AuthRepository>(AuthRepositoryRemote(authApi: Get.find()), permanent: true);
    // lazy: false,
    Get.put(
      AuthSessionNotifier(
        authSessionRepository: Get.find<AuthSessionRepository>(),
        sessionEnded: Get.find<AuthInterceptor>().onUnauthorized,
      ),
      permanent: true,
    );
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
