import 'package:efood/ui/auth/forgot_password/forgot_password_bindings.dart';
import 'package:efood/ui/auth/forgot_password/forgot_password_screen.dart';
import 'package:efood/ui/auth/login/login_bindings.dart';
import 'package:efood/ui/auth/register/register_bindings.dart';
import 'package:efood/ui/auth/register/register_screen.dart';
import 'package:efood/ui/auth/signup/signup_screen.dart';
import 'package:efood/ui/auth/signup/signup_bindings.dart';
import 'package:efood/ui/auth/signup/signup_viewmodel.dart';
import 'package:efood/ui/auth/verification/verification_bindings.dart';
import 'package:efood/ui/auth/verification/verification_screen.dart';
import 'package:efood/ui/dashboard/dashboard_bindings.dart';
import 'package:efood/ui/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:efood/routing/app_routes.dart';
// import 'package:efood/routing/auth_middleware.dart';
import 'package:efood/ui/auth/login/login_screen.dart';
import 'package:efood/ui/onboarding/onboarding_bindings.dart';
import 'package:efood/ui/onboarding/onboarding_screen.dart';
import 'package:efood/ui/splash/splash_bindings.dart';
import 'package:efood/ui/splash/splash_screen.dart';
import 'package:efood/ui/welcome/welcome_screen.dart';

class AppRouter._() {
  // static final _auth = [AuthMiddleware()];

  static List<GetPage> pages = [
    GetPage(
      // middlewares: _auth,
      name: AppRoutes.splash,
      binding: SplashBindings(),
      page: () {
        return SplashScreen(viewModel: Get.find());
      },
    ),
    GetPage(
      // middlewares: _auth,
      name: AppRoutes.onboarding,
      binding: OnboardingBinding(),
      page: () => OnboardingScreen(viewModel: Get.find()),
    ),

    GetPage(name: AppRoutes.welcome, page: () => WelcomeScreen()),
    GetPage(
      name: AppRoutes.login,
      binding: LoginBindings(),
      page: () => LoginScreen(viewModel: Get.find()),
    ),
    GetPage(
      name: AppRoutes.signup,
      binding: SignUpBindings(),
      page: () => SignUpScreen(viewModel: Get.find<SignUpViewModel>()),
    ),
    GetPage(
      name: AppRoutes.register,
      binding: RegisterBindings(),
      page: () => RegisterScreen(viewModel: Get.find()),
    ),
    GetPage(
      name: AppRoutes.verify,
      binding: VerificationBindings(),
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? const <String, dynamic>{};

        return VerificationScreen(
          viewModel: Get.find(),
          emailAddress: arguments['emailAddress'] as String? ?? '',
          fromSignUp: arguments['fromSignUp'] as bool? ?? false,
        );
      },
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      binding: ForgotPasswordBindings(),
      page: () => ForgotPasswordScreen(viewModel: Get.find()),
    ),

    GetPage(
      name: AppRoutes.main,
      binding: DashboardBindings(),
      page: () => DashboardScreen(viewModel: Get.find(), homeViewModel: Get.find()),
    ),
  ];
}
