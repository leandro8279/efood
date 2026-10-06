import 'package:efood/core/auth/auth_session_notifier.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/routing/auth_middleware.dart';
import 'package:efood/ui/auth/login/login_screen.dart';
import 'package:efood/ui/onboarding/onboarding_bindings.dart';
import 'package:efood/ui/onboarding/onboarding_screen.dart';
import 'package:efood/ui/onboarding/onboarding_viewmodel.dart';
import 'package:efood/ui/splash/splash_bindings.dart';
import 'package:efood/ui/splash/splash_screen.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';
import 'package:get/get.dart';

class AppRouter._() {
  static final _auth = [AuthMiddleware()];

  static List<GetPage> pages = [
    GetPage(
      // middlewares: _auth,
      name: AppRoutes.splash,
      binding: SplashBindings(),
      page: () {
        return SplashScreen(viewModel: Get.find<SplashViewModel>(), sessionNotifier: Get.find<AuthSessionNotifier>());
      },
    ),
    GetPage(
      // middlewares: _auth,
      name: AppRoutes.onboarding,
      binding: OnboardingBinding(),
      page: () => OnboardingScreen(viewModel: Get.find<OnBoardingViewModel>()),
    ),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  ];
}
