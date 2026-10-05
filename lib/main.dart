import 'package:efood/core/logging/app_logger.dart';
import 'package:efood/core/logging/log_output.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/routing/app_router.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:efood/config/application_bindings.dart';
import 'package:efood/ui/core/localization/app_translations.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  AppLogger.configure(level: kDebugMode ? Level.ALL : Level.INFO, outputs: const [ConsoleLogOutput()]);

  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    GetMaterialApp(
      theme: AppTheme.dark,
      locale: Get.deviceLocale,
      getPages: AppRouter.pages,
      initialRoute: AppRoutes.splash,
      translations: AppTranslations(),
      fallbackLocale: const Locale('pt', 'BR'),
      initialBinding: ApplicationBindings(sharedPreferences: sharedPreferences),
    ),
  );
}
