import 'package:efood/routing/app_routes.dart';
import 'package:efood/routing/auth_middleware.dart';
import 'package:efood/ui/auth/login/login_screen.dart';
import 'package:efood/ui/onboarding/onboarding_screen.dart';
import 'package:efood/ui/onboarding/onboarding_viewmodel.dart';
import 'package:efood/ui/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRouter._() {
  static final _auth = [AuthMiddleware()];

  static List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(viewModel: Get.find<OnBoardingViewModel>()),
      middlewares: _auth,
    ),
    GetPage(name: AppRoutes.login, page: () => LoginScreen(), middlewares: _auth),
  ];
}
