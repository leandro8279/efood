import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const NoDataScreen({
  super.key,
  final bool isCart = false,
  final bool isNothing = false,
  final bool isOrder = false,
  final bool isFooter = true,
  final bool isAddress = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: height < 600 ? height : height - 400),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppDimens.paddingLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        isOrder
                            ? AppAssets.images.clock
                            : isCart
                            ? AppAssets.images.shoppingCart
                            : isAddress
                            ? AppAssets.images.noAddress
                            : AppAssets.images.noFoodImage,
                        width: MediaQuery.of(context).size.height * 0.22,
                        height: MediaQuery.of(context).size.height * 0.22,
                        //color: Theme.of(context).primaryColor,
                      ),

                      Text(
                        isOrder
                            ? 'no_order_history_available'
                            : isCart
                            ? 'empty_cart'
                            : 'nothing_found'.tr,
                        style: AppTextStyles.rubikBold.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: MediaQuery.of(context).size.height * 0.023,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),

                      Text(
                        isOrder
                            ? 'buy_something_to_see'.tr
                            : isCart
                            ? 'look_like_have_not_added'.tr
                            : '',
                        style: AppTextStyles.rubikMedium.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.0175,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
