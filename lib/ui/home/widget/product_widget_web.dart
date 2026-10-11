import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/share/wish_button.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const ProductWidgetWeb({
  super.key,
  required final Config? config,
  required final Product product,
  final bool? fromPopularItem,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double? endingPrice;
    double? startingPrice;
    String productImageUrl = config?.baseUrls.productImageUrl ?? '';
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

    double priceDiscount = PriceConverter.convertDiscount(
      price: product.price,
      discount: product.discount,
      discountType: product.discountType,
    );

    bool isAvailable = product.availableTimeStarts.isNotEmpty && product.availableTimeEnds.isNotEmpty
        ? DateConverter.isAvailable(start: product.availableTimeStarts, end: product.availableTimeEnds)
        : false;

    return InkWell(
      onTap: () => {
        // _addToCart(context, _cartIndex)
      },
      child: Stack(
        children: [
          Container(
            // height: 220,
            // width: 170,
            decoration: BoxDecoration(
              color: AppColors.getCartColor(),
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
                        fit: BoxFit.cover,
                        height: 105,
                        width: 195,
                        image: '$productImageUrl/${product.image}',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          AppAssets.images.placeholderRectangle,
                          fit: BoxFit.cover,
                          height: 105,
                          width: 195,
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

                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.rubikMedium.copyWith(
                            fontSize: AppDimens.fontSizeSmall,
                            color: AppColors.getCartTitleColor(),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppDimens.paddingExtraSmall),

                        RatingBar(
                          rating: product.rating.isNotEmpty ? double.parse(product.rating[0]!.average) : 0.0,
                          size: AppDimens.paddingDefault,
                        ),
                        SizedBox(height: AppDimens.paddingExtraSmall),

                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              priceDiscount > 0
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraSmall),
                                      child: Text(
                                        '${PriceConverter.convertPrice(price: startingPrice, config: config)}'
                                        '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, config: config)}' : ''}',
                                        style: AppTextStyles.rubikBold.copyWith(
                                          fontSize: AppDimens.fontSizeExtraSmall,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              Text(
                                '${PriceConverter.convertPrice(price: startingPrice, discount: product.discount, discountType: product.discountType, config: config)}'
                                '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, discount: product.discount, discountType: product.discountType, config: config)}' : ''}',
                                style: AppTextStyles.rubikBold.copyWith(
                                  fontSize: AppDimens.fontSizeSmall,
                                  color: AppColors.appBarHeader,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppDimens.paddingExtraSmall),

                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 100,
                            child: FittedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appBarHeader,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () => {
                                  // _addToCart(context, _cartIndex)
                                },
                                child: Text(
                                  'quick_view'.tr,
                                  style: AppTextStyles.robotoRegular.copyWith(fontSize: AppDimens.fontSizeSmall),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WishButton(product: product),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, int cartIndex) {
    // ResponsiveHelper.isMobile(context)
    //     ? showModalBottomSheet(
    //         context: context,
    //         isScrollControlled: true,
    //         backgroundColor: Colors.transparent,
    //         builder: (con) => CartBottomSheet(
    //           product: product,
    //           cart: _cartIndex != null ? Provider.of<CartProvider>(context, listen: false).cartList[_cartIndex] : null,
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
    //             fromSetMenu: true,
    //             cart: _cartIndex != null
    //                 ? Provider.of<CartProvider>(context, listen: false).cartList[_cartIndex]
    //                 : null,
    //             callback: (CartModel cartModel) {
    //               showCustomSnackBar('added_to_cart'.tr, context, isError: false);
    //             },
    //           ),
    //         ),
    //       );
  }
}
