import 'package:efood/config/constants.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/app_text_styles.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const SplashScreen({
  super.key,
  required final SplashViewModel viewModel,
}) extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;
  Worker? _configWorker;
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _configWorker = ever(widget.viewModel.config, (_) => _onConfigChanged());

    _onConfigChanged();
  }

  void _onConfigChanged() {
    if (!mounted || widget.viewModel.config.value == null || _navigated) return;

    _navigated = true;

    _configWorker?.dispose();

    if (mounted) Get.offAllNamed(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _configWorker?.dispose();
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
