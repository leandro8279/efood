// ignore_for_file: unnecessary_null_comparison

import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetMenuScreen extends StatelessWidget {
  const new({super.key});
  ConfigNotifier get configNotifier => Get.find<ConfigNotifier>();

  @override
  Widget build(BuildContext context) {
    final productImageUrl = configNotifier.config.value?.baseUrls.productImageUrl ?? '';

    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'set_menu'.tr),
      body: RenderConditional(
        conditional: true, //setMenu.setMenuList != null
        widget1: RenderConditional(
          conditional: true, //setMenu.setMenuList.length > 0
          widget1: RefreshIndicator(
            onRefresh: () async {
              // await Provider.of<SetMenuProvider>(context, listen: false).getSetMenuList(
              //   context,
              //   true,
              //   Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
              // );
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 0, // setMenu.setMenuList.length,
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 13,
                        childAspectRatio: 1 / 1.2,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        double? startingPrice;
                        double? endingPrice;
                        if (setMenu.setMenuList[index].choiceOptions.length != 0) {
                          // List<double> priceList = [];
                          // setMenu.setMenuList[index].variations.forEach((variation) => priceList.add(variation.price));
                          // priceList.sort((a, b) => a.compareTo(b));
                          // startingPrice = priceList[0];
                          // if (priceList[0] < priceList[priceList.length - 1]) {
                          //   _endingPrice = priceList[priceList.length - 1];
                          // }
                        } else {
                          // startingPrice = setMenu.setMenuList[index].price;
                        }

                        double discount =
                            setMenu.setMenuList[index].price -
                            PriceConverter.convertWithDiscount(
                              price: setMenu.setMenuList[index].price,
                              discount: setMenu.setMenuList[index].discount,
                              discountType: setMenu.setMenuList[index].discountType,
                            );

                        bool isAvailable = DateConverter.isAvailable(
                          start: setMenu.setMenuList[index].availableTimeStarts,
                          end: setMenu.setMenuList[index].availableTimeEnds,
                        );

                        return Obx(() {
                          int cartIndex = 0; //_cartProvider.getCartIndex(setMenu.setMenuList[index]);
                          return InkWell(
                            onTap: () {
                              // ResponsiveHelper.isMobile(context)
                              //     ? showModalBottomSheet(
                              //         context: context,
                              //         isScrollControlled: true,
                              //         backgroundColor: Colors.transparent,
                              //         builder: (con) => CartBottomSheet(
                              //           product: setMenu.setMenuList[index],
                              //           fromSetMenu: true,
                              //           cart: cartIndex != null ? _cartProvider.cartList[cartIndex] : null,
                              //           callback: (CartModel cartModel) {
                              //             showCustomSnackBar('added_to_cart'.tr, context, isError: false);
                              //           },
                              //         ),
                              //       )
                              //     : showDialog(
                              //         context: context,
                              //         builder: (con) => Dialog(
                              //           child: CartBottomSheet(
                              //             product: setMenu.setMenuList[index],
                              //             fromSetMenu: true,
                              //             cart: cartIndex != null ? _cartProvider.cartList[cartIndex] : null,
                              //             callback: (CartModel cartModel) {
                              //               showCustomSnackBar('added_to_cart'.tr, context, isError: false);
                              //             },
                              //           ),
                              //         ),
                              //       );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                                    blurRadius: Get.isDarkMode ? 2 : 5,
                                    spreadRadius: Get.isDarkMode ? 0 : 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: AppAssets.images.placeholderRectangle,
                                          height: 110,
                                          width: MediaQuery.of(context).size.width / 2,
                                          fit: BoxFit.cover,
                                          image: '$productImageUrl/${setMenu.setMenuList[index].image}',
                                          imageErrorBuilder: (c, o, s) => Image.asset(
                                            AppAssets.images.placeholderRectangle,
                                            height: 110,
                                            width: MediaQuery.of(context).size.width / 2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      RenderConditional(
                                        conditional: isAvailable,
                                        widget1: SizedBox(),
                                        widget2: Positioned(
                                          top: 0,
                                          left: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                              color: Colors.black.withOpacity(0.6),
                                            ),
                                            child: Text(
                                              'not_available_now'.tr,
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.rubikRegular.copyWith(
                                                color: Colors.white,
                                                fontSize: AppDimens.fontSizeSmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            setMenu.setMenuList[index].name,
                                            style: AppTextStyles.rubikMedium.copyWith(
                                              fontSize: AppDimens.fontSizeSmall,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: AppDimens.paddingExtraSmall),

                                          RatingBar(
                                            rating: setMenu.setMenuList[index].rating.length > 0
                                                ? double.parse(setMenu.setMenuList[index].rating[0].average)
                                                : 0.0,
                                            size: 12,
                                          ),
                                          SizedBox(height: AppDimens.paddingExtraSmall),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${PriceConverter.convertPrice(context, startingPrice, discount: setMenu.setMenuList[index].discount, discountType: setMenu.setMenuList[index].discountType)}'
                                                '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, discount: setMenu.setMenuList[index].discount, discountType: setMenu.setMenuList[index].discountType, config: configNotifier.config.value)}' : ''}',
                                                style: AppTextStyles.rubikBold.copyWith(
                                                  fontSize: AppDimens.fontSizeSmall,
                                                ),
                                              ),
                                              discount > 0
                                                  ? SizedBox()
                                                  : Icon(Icons.add, color: AppTextStyles.bodyText1().color),
                                            ],
                                          ),
                                          RenderConditional(
                                            conditional: discount > 0,
                                            widget1: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${PriceConverter.convertPrice(price: startingPrice, config: configNotifier.config.value)}'
                                                  '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, config: configNotifier.config.value)}' : ''}',
                                                  style: AppTextStyles.rubikBold.copyWith(
                                                    fontSize: AppDimens.fontSizeExtraSmall,
                                                    color: AppColors.getGreyColor(),
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                                Icon(Icons.add, color: AppTextStyles.bodyText1().color),
                                              ],
                                            ),
                                            widget2: SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
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
    );
  }
}
