import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotLoggedInScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: height < 600 ? height : height - 400),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.images.guestLogin,
                        width: MediaQuery.of(context).size.height * 0.25,
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                      Text(
                        'guest_mode'.tr,
                        style: AppTextStyles.rubikBold.copyWith(fontSize: MediaQuery.of(context).size.height * 0.023),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      Text(
                        'now_you_are_in_guest_mode'.tr,
                        style: AppTextStyles.rubikRegular.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.0175,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                      SizedBox(
                        width: 100,
                        height: 40,
                        child: CustomButton(btnTxt: 'login'.tr, onTap: () => Get.toNamed(AppRoutes.login)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
