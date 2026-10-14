import 'package:efood/domain/models/config/config.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const MenuScreen({super.key, required final MenuViewModel viewModel}) extends StatefulWidget {

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ConfigNotifier configNotifier = Get.find<ConfigNotifier>();

  Config? config;

  @override
  void initState() {
    config = configNotifier.config.value!;
    // TODO: implement initState
    super.initState();
    // _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    // if (_isLoggedIn) {
    //   Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              width: 1170,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: ClipOval(
                      child: RenderConditional(
                        conditional: viewModel.isSignedIn,
                        widget1: FadeInImage.assetNetwork(
                          placeholder: AppAssets.images.placeholderUser,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          image:
                              '${config!.baseUrls.customerImageUrl}/'
                              '${profileProvider.userInfoModel != null ? profileProvider.userInfoModel.image : ''}',
                          imageErrorBuilder: (c, o, s) =>
                              Image.asset(AppAssets.images.placeholderUser, height: 80, width: 80, fit: BoxFit.cover),
                        ),
                        widget2: Image.asset(
                          AppAssets.images.placeholderUser,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      RenderConditional(
                        conditional: viewModel.isSignedIn,
                        widget1: RenderConditional(
                          conditional: true, //  profileProvider.userInfoModel != null
                          widget1: Text(
                            '${profileProvider.userInfoModel.fName ?? ''} ${profileProvider.userInfoModel.lName ?? ''}',
                            style: AppTextStyles.rubikRegular.copyWith(
                              fontSize: AppDimens.fontSizeExtraLarge,
                              color: AppColors.white,
                            ),
                          ),
                          widget2: Container(height: 15, width: 150, color: Colors.white),
                        ),
                        widget2: Text(
                          'guest'.tr,
                          style: rubikRegular.copyWith(fontSize: AppDimens.fontSizeExtraLarge, color: AppColors.white),
                        ),
                      ),

                      SizedBox(height: 10),
                      RenderConditional(
                        conditional: viewModel.isSignedIn,
                        widget1: RenderConditional(
                          conditional: true, // profileProvider.userInfoModel != null
                          widget1: Text(
                            '${profileProvider.userInfoModel.email ?? ''}',
                            style: AppTextStyles.rubikRegular.copyWith(color: AppColors.background),
                          ),
                          widget2: Container(height: 15, width: 100, color: Colors.white),
                        ),
                        widget2: Text(
                          'demo@demo.com',
                          style: AppTextStyles.rubikRegular.copyWith(
                            fontSize: AppDimens.fontSizeExtraLarge,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      RenderConditional(
                        conditional: viewModel.isSignedIn,
                        widget1: RenderConditional(
                          conditional: true, //profileProvider.userInfoModel != null
                          widget1: Text(
                            '${'points'.tr}: ${profileProvider.userInfoModel.point ?? ''}',
                            style: AppTextStyles.rubikRegular.copyWith(color: AppColors.background),
                          ),
                          widget2: Container(height: 15, width: 100, color: Colors.white),
                        ),
                        widget2: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: OptionsView(onTap: widget.onTap)),
        ],
      ),
    );
  }
}
