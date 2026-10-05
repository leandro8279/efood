import 'package:efood/config/constants.dart';
import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/core/theme/app_text_styles.dart';
import 'package:efood/ui/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';

class const SplashScreen({super.key, required final SplashViewModel viewModel}) extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadConfig.addListener(_onConfigResult);
  }

  void _onConfigResult() {
    final config = widget.viewModel.config;

    double _minimumVersion = 0.0;
    // if (Platform.isAndroid) {
    //   if (Provider.of<SplashProvider>(context, listen: false).configModel.playStoreConfig.minVersion != null) {
    //     _minimumVersion =
    //         Provider.of<SplashProvider>(context, listen: false).configModel.playStoreConfig.minVersion ?? 4.0;
    //   }
    // } else if (Platform.isIOS) {
    //   if (Provider.of<SplashProvider>(context, listen: false).configModel.appStoreConfig.minVersion != null) {
    //     _minimumVersion =
    //         Provider.of<SplashProvider>(context, listen: false).configModel.appStoreConfig.minVersion ?? 4.0;
    //   }
    // }
    // if (AppConstants.APP_VERSION < _minimumVersion && !ResponsiveHelper.isWeb()) {
    //   Navigator.pushNamedAndRemoveUntil(context, Routes.getUpdateRoute(), (route) => false);
    // } else

    if (config?.maintenanceMode == true) {
      // Navigator.pushNamedAndRemoveUntil(context, Routes.getMaintainRoute(), (route) => false);
    } else {}
    //   if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
    //     Provider.of<AuthProvider>(context, listen: false).updateToken();
    //     // await Provider.of<WishListProvider>(context, listen: false).initWishList(
    //     //   context, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
    //     // );
    //     Navigator.pushNamedAndRemoveUntil(context, Routes.getMainRoute(), (route) => false);
    //   } else {
    //     Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       ResponsiveHelper.isMobile(context)
    //           ? Provider.of<OnBoardingProvider>(context, listen: false).showOnBoardingStatus
    //                 ? Routes.getLanguageRoute('splash')
    //                 : Routes.getMainRoute()
    //           : Routes.getMainRoute(),
    //       (route) => false,
    //     );
    //   }
    // }
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
