import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: 1170,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: .all(30),
                    child: Image.asset(AppAssets.images.logo, height: 200),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'welcome'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline3().copyWith(fontSize: 32),
                  ),
                  Padding(
                    padding: const .all(AppDimens.paddingDefault),
                    child: Text(
                      'welcome_to_efood'.tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headline2(color: AppColors.greyDark),
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const .all(AppDimens.paddingDefault),
                    child: CustomButton(btnTxt: 'login'.tr, onTap: () => Get.offAllNamed(AppRoutes.login)),
                  ),
                  Padding(
                    padding: const .only(
                      left: AppDimens.paddingDefault,
                      right: AppDimens.paddingDefault,
                      bottom: AppDimens.paddingDefault,
                      top: 12,
                    ),
                    child: CustomButton(
                      btnTxt: 'signup'.tr,
                      onTap: () => Get.offAllNamed(AppRoutes.signup),
                      backgroundColor: Colors.black,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(minimumSize: Size(1, 40)),
                    onPressed: () => Get.offAllNamed(AppRoutes.main),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${'login_as_a'.tr} ',
                            style: AppTextStyles.rubikRegular.copyWith(color: AppColors.greyDark),
                          ),
                          TextSpan(text: 'guest'.tr, style: AppTextStyles.rubikMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
