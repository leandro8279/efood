import 'dart:async';

import 'package:efood/config/constants.dart';
import 'package:efood/core/auth/auth_session_notifier.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/core/theme/app_text_styles.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const SplashScreen({
  super.key,
  required final SplashViewModel viewModel,
  required final AuthSessionNotifier _sessionNotifier,
}) extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    widget.viewModel.loadConfig.addListener(_onConfigCommandChanged);
  }

  void _onConfigCommandChanged() {
    final command = widget.viewModel.loadConfig;

    if (!mounted || !command.complete || _navigated) return;

    _navigated = true;

    command.removeListener(_onConfigCommandChanged);

    if (mounted) Get.offAllNamed(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    widget.viewModel.loadConfig.removeListener(_onConfigCommandChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.images.logo, height: 150),
            SizedBox(height: 30),
            Text(
              AppConstants.appName,
              style: AppTextStyles.rubikBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
