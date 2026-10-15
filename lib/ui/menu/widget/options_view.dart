import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/config/policy.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const OptionsView({
  super.key,
  required final Function onTap,
  required final Policy? policy,
  required final bool isSignedIn,
  required final Config? config,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  value: Get.isDarkMode,
                  onChanged: (bool isActive) => Get.changeTheme(isActive ? ThemeData.fallback() : ThemeData.light()),
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
                    AppAssets.icons.location,
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
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getLanguageRoute('menu')),
                  },
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
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getSupportRoute())
                  },
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(AppAssets.images.helpSupport, color: AppColors.getWhiteAndBlack()),
                  ),
                  title: Text(
                    'help_and_support'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getPolicyRoute())
                  },
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(AppAssets.images.privacyPolicy, color: AppColors.getWhiteAndBlack()),
                  ),
                  title: Text(
                    'privacy_policy'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getTermsRoute())
                  },
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(AppAssets.images.termsAndCondition, color: AppColors.getWhiteAndBlack()),
                  ),
                  title: Text(
                    'terms_and_condition'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ),

                RenderConditional(
                  conditional: policy != null && policy?.returnPage != null && policy!.returnPage?.status != null,
                  widget1: ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.getReturnPolicyRoute())
                    },
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
                  widget2: SizedBox.shrink(),
                ),

                RenderConditional(
                  conditional: policy != null && policy?.refundPage != null && policy!.refundPage?.status != null,
                  widget1: ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.getRefundPolicyRoute())
                    },
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
                  widget2: SizedBox.shrink(),
                ),
                RenderConditional(
                  conditional:
                      policy != null && policy!.cancellationPage != null && policy!.cancellationPage?.status != null,
                  widget1: ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.getCancellationPolicyRoute())
                    },
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
                  widget2: SizedBox.shrink(),
                ),

                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getAboutUsRoute())
                  },
                  leading: SizedBox(
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
                    AppAssets.icons.version,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    'version'.tr,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                  trailing: Text(
                    '${config?.softwareVersion ?? ''}',
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                  //
                ),
                RenderConditional(
                  conditional: isSignedIn,
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
                    AppAssets.images.login,
                    width: 20,
                    height: 20,
                    color: AppTextStyles.bodyText1().color,
                  ),
                  title: Text(
                    isSignedIn ? 'logout' : 'login'.tr,
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
