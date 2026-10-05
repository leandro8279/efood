import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:efood/config/application_bindings.dart';
import 'package:efood/ui/core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    GetMaterialApp(
      theme: AppTheme.dark,
      getPages: AppRouter.pages,
      initialRoute: AppRoutes.splash,
      initialBinding: ApplicationBindings(sharedPreferences: sharedPreferences),
    ),
  );
}
