import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const OptionsView({super.key, required final Function onTap}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    final policyModel = Provider.of<SplashProvider>(context, listen: false).policyModel;
    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 1170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0),

                SwitchListTile(
                  value: true, //Provider.of<ThemeProvider>(context).darkTheme,
                  onChanged: (bool isActive) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                  title: Text(
                    'dark_theme'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                  activeThumbColor: Theme.of(context).primaryColor,
                ),

                ListTile(
                  onTap: () => onTap(2),
                  leading: Image.asset(
                    AppAssets.images.order,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'my_order'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getProfileRoute())
                  },
                  leading: Image.asset(
                    AppAssets.images.profile,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'profile'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getAddressRoute())
                  },
                  leading: Image.asset(
                    AppAssets.images.location,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'address'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getChatRoute(orderModel: null))
                  },
                  leading: Image.asset(
                    AppAssets.images.message,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'message'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getCouponRoute())
                  },
                  leading: Image.asset(
                    AppAssets.images.coupon,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'coupon'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),

                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getLanguageRoute('menu')),
                  leading: Image.asset(
                    AppAssets.images.language,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'language'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getSupportRoute()),
                  leading: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(AppAssets.images.help_support, color: AppColors.getWhiteAndBlack(context)),
                  ),
                  title: Text(
                    'help_and_support'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getPolicyRoute()),
                  leading: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(AppAssets.images.privacy_policy, color: AppColors.getWhiteAndBlack(context)),
                  ),
                  title: Text(
                    'privacy_policy'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getTermsRoute()),
                  leading: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      AppAssets.images.terms_and_condition,
                      color: AppColors.getWhiteAndBlack(context),
                    ),
                  ),
                  title: Text(
                    'terms_and_condition'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),

                if (policyModel != null && policyModel.returnPage != null && policyModel.returnPage.status)
                  ListTile(
                    onTap: () => Navigator.pushNamed(context, Routes.getReturnPolicyRoute()),
                    leading: Image.asset(
                      AppAssets.images.returnPolicy,
                      width: 20,
                      height: 20,
                      color: AppTextStyles.bodyText1().color,
                    ),
                    title: Text(
                      'return_policy'.tr,
                      style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                    ),
                  ),

                if (policyModel != null && policyModel.refundPage != null && policyModel.refundPage.status)
                  ListTile(
                    onTap: () => Navigator.pushNamed(context, Routes.getRefundPolicyRoute()),
                    leading: Image.asset(
                      AppAssets.images.refundPolicy,
                      width: 20,
                      height: 20,
                      color: AppTextStyles.bodyText1().color,
                    ),
                    title: Text(
                      'refund_policy'.tr,
                      style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                    ),
                  ),
                if (policyModel != null && policyModel.cancellationPage != null && policyModel.cancellationPage.status)
                  ListTile(
                    onTap: () => Navigator.pushNamed(context, Routes.getCancellationPolicyRoute()),
                    leading: Image.asset(
                      AppAssets.images.cancellationPolicy,
                      width: 20,
                      height: 20,
                      color: AppTextStyles.bodyText1().color,
                    ),
                    title: Text(
                      'cancellation_policy'.tr,
                      style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                    ),
                  ),

                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getAboutUsRoute()),
                  leading: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(AppAssets.images.aboutUs, color: AppColors.getWhiteAndBlack()),
                  ),
                  title: Text(
                    'about_us'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),

                ListTile(
                  leading: Image.asset(
                    AppAssets.images.version,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    '${'version'.tr}',
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                  trailing: Text(
                    '${Provider.of<SplashProvider>(context, listen: false).configModel.softwareVersion ?? ''}',
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                  //
                ),
                RenderConditional(
                  conditional: isLoggedIn,
                  widget1: ListTile(
                    onTap: () {
                      // showAnimatedDialog(
                      //   context,
                      //   Consumer<AuthProvider>(
                      //     builder: (context, authProvider, _) {
                      //       return WillPopScope(
                      //         onWillPop: () async => !authProvider.isLoading,
                      //         child: authProvider.isLoading
                      //             ? Center(child: CircularProgressIndicator())
                      //             : CustomDialog(
                      //                 icon: Icons.question_mark_sharp,
                      //                 title: 'are_you_sure_to_delete_account'.tr,
                      //                 description: 'it_will_remove_your_all_information'.tr,
                      //                 buttonTextTrue: 'yes'.tr,
                      //                 buttonTextFalse: 'no'.tr,
                      //                 onTapTrue: () =>
                      //                     Provider.of<AuthProvider>(context, listen: false).deleteUser(context),
                      //                 onTapFalse: () => Navigator.of(context).pop(),
                      //               ),
                      //       );
                      //     },
                      //   ),
                      //   dismissible: false,
                      //   isFlip: true,
                      // );
                    },
                    leading: Icon(Icons.delete_outline, size: 20, color: AppTextStyles.bodyText1().color),
                    title: Text(
                      'delete_account'.tr,
                      style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                    ),
                  ),
                  widget2: SizedBox(),
                ),

                ListTile(
                  onTap: () {
                    // if (isLoggedIn) {
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (context) => SignOutConfirmationDialog(),
                    //   );
                    // } else {
                    //   Navigator.pushNamed(context, Routes.getLoginRoute());
                    // }
                  },
                  leading: Image.asset(
                    AppAssets.AppAssets.images.login,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    isLoggedIn ? 'logout' : 'login'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
