// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class const SetMenuView({
  super.key,
  required final bool isLoading,
  required final Config? config,
  required final List<Product> setMenuProducts,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TitleWidget(
            title: 'set_menu'.tr,
            onTap: () {
              // Navigator.pushNamed(context, Routes.getSetMenuRoute());
            },
          ),
        ),

        SizedBox(
          height: 220,
          child: Obx(
            () => RenderConditional(
              conditional: !isLoading,
              widget1: RenderConditional(
                conditional: setMenuProducts.isNotEmpty,
                widget1: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: AppDimens.paddingSmall),
                  itemCount: setMenuProducts.length > 5 ? 5 : setMenuProducts.length,
                  itemBuilder: (context, index) {
                    final setMenuProduct = setMenuProducts[index];

                    late double? startingPrice;
                    late double? endingPrice = 0;
                    if (setMenuProduct.choiceOptions.isNotEmpty) {
                      List<double> priceList = [];
                      setMenuProduct.variations.forEach((variation) => priceList.add(variation.price));
                      priceList.sort((a, b) => a.compareTo(b));
                      startingPrice = priceList[0];
                      if (priceList[0] < priceList[priceList.length - 1]) {
                        endingPrice = priceList[priceList.length - 1];
                      }
                    } else {
                      startingPrice = setMenuProduct.price;
                    }

                    double discount =
                        setMenuProduct.price -
                        PriceConverter.convertWithDiscount(
                          price: setMenuProduct.price,
                          discount: setMenuProduct.discount,
                          discountType: setMenuProduct.discountType,
                        );

                    bool isAvailable = DateConverter.isAvailable(
                      start: setMenuProduct.availableTimeStarts,
                      end: setMenuProduct.availableTimeEnds,
                    );

                    return Padding(
                      padding: EdgeInsets.only(right: AppDimens.paddingSmall, bottom: 5),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 220,
                          width: 170,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: AppAssets.images.placeholderRectangle,
                                      height: 110,
                                      width: 170,
                                      fit: BoxFit.cover,
                                      image: '${config?.baseUrls.productImageUrl}/${setMenuProduct.image}',

                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        AppAssets.images.placeholderRectangle,
                                        height: 110,
                                        width: 170,
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
                                        setMenuProduct.name,
                                        style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeSmall),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: AppDimens.paddingExtraSmall),

                                      RatingBar(
                                        rating: setMenuProduct.rating.isNotEmpty
                                            ? double.parse(setMenuProduct.rating[0]!.average)
                                            : 0.0,
                                        size: 12,
                                      ),
                                      SizedBox(height: AppDimens.paddingExtraSmall),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${PriceConverter.convertPrice(price: startingPrice, discount: setMenuProduct.discount, discountType: setMenuProduct.discountType, config: config)}'
                                              '${' - ${PriceConverter.convertPrice(price: endingPrice, discount: setMenuProduct.discount, discountType: setMenuProduct.discountType, config: config)}'}',
                                              style: AppTextStyles.rubikBold.copyWith(
                                                fontSize: AppDimens.fontSizeSmall,
                                              ),
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
                                            Flexible(
                                              child: Text(
                                                '${PriceConverter.convertPrice(config: config, price: startingPrice)}'
                                                '${' - ${PriceConverter.convertPrice(config: config, price: endingPrice)}'}',
                                                style: AppTextStyles.rubikBold.copyWith(
                                                  fontSize: AppDimens.fontSizeExtraSmall,
                                                  color: AppColors.grey,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
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
                      ),
                    );
                  },
                ),
                widget2: Center(child: Text('no_set_menu_available'.tr)),
              ),
              widget2: SetMenuShimmer(setMenuProducts: setMenuProducts),
            ),
          ),
        ),
      ],
    );
  }
}

class const SetMenuShimmer({super.key, required final List<Product> setMenuProducts}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: AppDimens.paddingSmall),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          width: 150,
          margin: EdgeInsets.only(right: AppDimens.paddingSmall, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 1),
            interval: Duration(seconds: 1),
            enabled: setMenuProducts.isEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    color: Colors.grey[300],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.paddingSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 15, width: 130, color: Colors.grey[300]),

                        Align(alignment: Alignment.centerRight, child: RatingBar(rating: 0.0, size: 12)),
                        SizedBox(height: AppDimens.paddingExtraSmall),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(height: 10, width: 50, color: Colors.grey[300]),
                            Icon(Icons.add, color: AppColors.black),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
