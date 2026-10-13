import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CouponScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: 'coupon'.tr, context: context),
      body: RenderConditional(
        conditional: true, //_isLoggedIn
        widget1: RenderConditional(
          conditional: true,
          widget1: RenderConditional(
            conditional: true,
            widget1: RefreshIndicator(
              onRefresh: () async {
                // await Provider.of<CouponProvider>(context, listen: false).getCouponList(context);
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: height < 600 ? height : height - 400),
                          child: Container(
                            padding: width > 700 ? EdgeInsets.all(AppDimens.paddingLarge) : EdgeInsets.zero,
                            child: Container(
                              width: width > 700 ? 700 : width,
                              padding: width > 700 ? EdgeInsets.all(AppDimens.paddingDefault) : null,
                              decoration: width > 700
                                  ? BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1),
                                      ],
                                    )
                                  : null,
                              child: ListView.builder(
                                itemCount: 0,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(AppDimens.paddingLarge),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: AppDimens.paddingLarge),
                                    child: InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: 'coupon.couponList[index].code'));
                                        showCustomSnackBar('coupon_code_copied'.tr, context, isError: false);
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            AppAssets.images.couponBg,
                                            height: 100,
                                            width: 1170,
                                            fit: BoxFit.fitWidth,
                                            color: Theme.of(context).primaryColor,
                                          ),

                                          Container(
                                            height: 100,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                SizedBox(width: 50),
                                                Image.asset(AppAssets.images.percentage, height: 50, width: 50),

                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: AppDimens.paddingLarge,
                                                    vertical: AppDimens.paddingSmall,
                                                  ),
                                                  child: Image.asset(AppAssets.images.line, height: 100, width: 5),
                                                ),

                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SelectableText(
                                                        'coupon.couponList[index].code',
                                                        style: AppTextStyles.rubikRegular.copyWith(
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                      SizedBox(height: AppDimens.paddingExtraSmall),
                                                      Text(
                                                        '', //'${coupon.couponList[index].discount}${coupon.couponList[index].discountType == 'percent' ? '%' : Provider.of<SplashProvider>(context, listen: false).configModel.currencySymbol} off',
                                                        style: AppTextStyles.rubikMedium.copyWith(
                                                          color: AppColors.white,
                                                          fontSize: AppDimens.fontSizeExtraLarge,
                                                        ),
                                                      ),
                                                      SizedBox(height: AppDimens.paddingExtraSmall),
                                                      Text(
                                                        '', // '${'valid_until'.tr} ${DateConverter.isoStringToLocalDateOnly(coupon.couponList[index].expireDate)}',
                                                        style: AppTextStyles.rubikRegular.copyWith(
                                                          color: AppColors.white,
                                                          fontSize: AppDimens.fontSizeSmall,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            widget2: NoDataScreen(),
          ),
          widget2: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          ),
        ),
        widget2: NotLoggedInScreen(),
      ),
    );
  }
}
