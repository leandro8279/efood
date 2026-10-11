import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/share/wish_button.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const ProductWidget({super.key, required final Product product, required final Config? config})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double? endingPrice;
    double? startingPrice;

    String imagePathUrl = config?.baseUrls.productImageUrl ?? '';

    if (product.choiceOptions.isNotEmpty) {
      List<double> priceList = [];
      product.variations.forEach((variation) => priceList.add(variation.price));
      priceList.sort((a, b) => a.compareTo(b));
      startingPrice = priceList[0];
      if (priceList[0] < priceList[priceList.length - 1]) {
        endingPrice = priceList[priceList.length - 1];
      }
    } else {
      startingPrice = product.price;
    }

    double discountedPrice = PriceConverter.convertWithDiscount(
      price: product.price,
      discount: product.discount,
      discountType: product.discountType,
    );

    bool isAvailable = DateConverter.isAvailable(start: product.availableTimeStarts, end: product.availableTimeEnds);

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingSmall),
      child: InkWell(
        onTap: () {
          // ResponsiveHelper.isMobile(context)
          //     ? showModalBottomSheet(
          //         context: context,
          //         isScrollControlled: true,
          //         backgroundColor: Colors.transparent,
          //         builder: (con) => CartBottomSheet(
          //           product: product,
          //           cart: _cartIndex != null ? _cartProvider.cartList[_cartIndex] : null,
          //           callback: (CartModel cartModel) {
          //             showCustomSnackBar('added_to_cart'.tr, context, isError: false);
          //           },
          //         ),
          //       )
          //     : showDialog(
          //         context: context,
          //         builder: (con) => Dialog(
          //           child: CartBottomSheet(
          //             product: product,
          //             cart: _cartIndex != null ? _cartProvider.cartList[_cartIndex] : null,
          //             callback: (CartModel cartModel) {
          //               showCustomSnackBar('added_to_cart'.tr, context, isError: false);
          //             },
          //           ),
          //         ),
          //       );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppDimens.paddingExtraSmall, horizontal: AppDimens.paddingSmall),
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
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: AppAssets.images.placeholderImage,
                      height: 70,
                      width: 85,
                      fit: BoxFit.cover,
                      image: '$imagePathUrl/${product.image}',
                      imageErrorBuilder: (c, o, s) =>
                          Image.asset(AppAssets.images.placeholderImage, height: 70, width: 85, fit: BoxFit.cover),
                    ),
                  ),
                  isAvailable
                      ? SizedBox()
                      : Positioned(
                          top: 0,
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Text(
                              'not_available_now_break'.tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.rubikRegular.copyWith(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(width: AppDimens.paddingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.rubikMedium.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    RenderConditional(
                      conditional: product.rating.isNotEmpty,
                      widget1: RatingBar(
                        rating: product.rating.isNotEmpty ? double.parse(product.rating[0]!.average) : 0.0,
                        size: 10,
                      ),
                      widget2: SizedBox(),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${PriceConverter.convertPrice(price: startingPrice, discount: product.discount, discountType: product.discountType, config: config)}'
                      '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, discount: product.discount, discountType: product.discountType, config: config)}' : ''}',
                      style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.paddingExtraSmall),
                    ),
                    RenderConditional(
                      conditional: product.price > discountedPrice,
                      widget1: Text(
                        '${PriceConverter.convertPrice(config: config, price: startingPrice)}'
                        '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, config: config)}' : ''}',
                        style: AppTextStyles.rubikMedium.copyWith(
                          color: AppColors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: AppDimens.paddingExtraSmall,
                        ),
                      ),
                      widget2: SizedBox(),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WishButton(product: product, edgeInset: EdgeInsets.all(5)),

                  Expanded(child: SizedBox()),
                  Icon(Icons.add),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
