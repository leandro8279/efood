import 'package:efood/config/constants.dart';
import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/core/theme/app_text_styles.dart';

import 'package:flutter/material.dart';

class const SplashScreen({super.key}) extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

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
