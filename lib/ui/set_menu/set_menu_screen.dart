// ignore_for_file: unnecessary_null_comparison

import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/home/widget/cart_bottom_sheet.dart';
import 'package:efood/ui/set_menu/set_menu_viewmodel.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const SetMenuScreen({super.key, required final SetMenuViewModel viewModel}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productImageUrl = viewModel.config.baseUrls.productImageUrl;

    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'set_menu'.tr),
      body: RenderConditional(
        conditional: viewModel.isLoading,
        widget1: RenderConditional(
          conditional: viewModel.setMenuProducts.isNotEmpty,
          widget1: RefreshIndicator(
            onRefresh: () => viewModel.loadSetMenu.execute(),
            backgroundColor: Theme.of(context).primaryColor,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewModel.setMenuProducts.length,
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 13,
                        childAspectRatio: 1 / 1.2,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        double startingPrice;
                        double? endingPrice;
                        if (viewModel.setMenuProducts[index].choiceOptions.isNotEmpty) {
                          List<double> priceList = [];

                          for (var variantion in viewModel.setMenuProducts[index].variations) {
                            priceList.add(variantion.price);
                          }
                          priceList.sort((a, b) => a.compareTo(b));
                          startingPrice = priceList[0];
                          if (priceList[0] < priceList[priceList.length - 1]) {
                            endingPrice = priceList[priceList.length - 1];
                          }
                        } else {
                          startingPrice = viewModel.setMenuProducts[index].price;
                        }

                        double discount =
                            viewModel.setMenuProducts[index].price -
                            PriceConverter.convertWithDiscount(
                              price: viewModel.setMenuProducts[index].price,
                              discount: viewModel.setMenuProducts[index].discount,
                              discountType: viewModel.setMenuProducts[index].discountType,
                            );

                        bool isAvailable = DateConverter.isAvailable(
                          start: viewModel.setMenuProducts[index].availableTimeStarts,
                          end: viewModel.setMenuProducts[index].availableTimeEnds,
                        );

                        return Obx(() {
                          int? cartIndex = viewModel.cartNotifier.getCartIndex(viewModel.setMenuProducts[index]);
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (con) => CartBottomSheet(
                                  product: viewModel.setMenuProducts[index],
                                  fromSetMenu: true,
                                  cart: cartIndex != null ? viewModel.cartNotifier.carts[cartIndex] : null,
                                  callback: (Cart cartModel) {
                                    showCustomSnackBar('added_to_cart'.tr, context, isError: false);
                                  },
                                ),
                              );
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
                                          image: '$productImageUrl/${viewModel.setMenuProducts[index].image}',
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
                                            viewModel.setMenuProducts[index].name,
                                            style: AppTextStyles.rubikMedium.copyWith(
                                              fontSize: AppDimens.fontSizeSmall,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: AppDimens.paddingExtraSmall),

                                          RatingBar(
                                            rating: viewModel.setMenuProducts[index].rating.isNotEmpty
                                                ? double.parse(viewModel.setMenuProducts[index].rating[0].average)
                                                : 0.0,
                                            size: 12,
                                          ),
                                          SizedBox(height: AppDimens.paddingExtraSmall),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${PriceConverter.convertPrice(price: startingPrice, discount: viewModel.setMenuProducts[index].discount, discountType: viewModel.setMenuProducts[index].discountType, config: viewModel.config)}'
                                                '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, discount: viewModel.setMenuProducts[index].discount, discountType: viewModel.setMenuProducts[index].discountType, config: viewModel.config)}' : ''}',
                                                style: AppTextStyles.rubikBold.copyWith(
                                                  fontSize: AppDimens.fontSizeSmall,
                                                ),
                                              ),
                                              RenderConditional(
                                                conditional: discount > 0,
                                                widget1: SizedBox(),
                                                widget2: Icon(Icons.add, color: AppTextStyles.bodyText1().color),
                                              ),
                                            ],
                                          ),
                                          RenderConditional(
                                            conditional: discount > 0,
                                            widget1: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${PriceConverter.convertPrice(price: startingPrice, config: viewModel.config)}'
                                                  '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, config: viewModel.config)}' : ''}',
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
