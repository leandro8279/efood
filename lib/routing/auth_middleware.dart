import 'package:efood/utils/auth/auth_session_notifier.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final _log = AppLogger('AuthMiddleware');

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    _log.info("ROUTER => $route");
    final session = Get.find<AuthSessionNotifier>();

    _log.info("SESSION => $session");

    if (route == AppRoutes.splash) return null;
    if (!session.isRestored) return null;

    final isPublic = AppRoutes.public.contains(route);

    if (!session.isSignedIn) {
      return isPublic ? null : const RouteSettings(name: AppRoutes.login);
    }

    return isPublic ? const RouteSettings(name: AppRoutes.home) : null;
  }
}
