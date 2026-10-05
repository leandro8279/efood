import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/splash/splash_binding.dart';
import 'package:efood/ui/splash/splash_screen.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';
import 'package:get/get.dart';

class AppRouter._() {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      binding: SplashBinding(),
      page: () => SplashScreen(viewModel: Get.find<SplashViewModel>()),
    ),
  ];
}
