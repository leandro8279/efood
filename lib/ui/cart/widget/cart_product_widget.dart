import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/home/widget/cart_bottom_sheet.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const CartProductWidget({
  super.key,
  required final Cart cart,
  required final int cartIndex,
  required final bool isAvailable,
  required final List<ProductAddOn> addOns,
}) extends StatelessWidget {
  ConfigNotifier get _configNotifier => Get.find<ConfigNotifier>();

  @override
  Widget build(BuildContext context) {
    String variationText = '';
    if (cart.variation.isNotEmpty) {
      List<String> variationTypes = cart.variation.isNotEmpty ? cart.variation[0]!.type.split('-') : [];

      if (variationTypes.length == cart.product.choiceOptions.length) {
        int index = 0;
        for (var choice in cart.product.choiceOptions) {
          variationText = '$variationText${(index == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index]}';
          index = index + 1;
        }
      } else {
        variationText = cart.product.variations[0].type;
      }
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (con) => CartBottomSheet(
            fromSetMenu: false,
            product: cart.product,
            cartIndex: cartIndex,
            cart: cart,
            fromCart: true,
            callback: (Cart cartModel) => showCustomSnackBar('updated_in_cart'.tr, context, isError: false),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimens.paddingDefault),
        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Icon(Icons.delete, color: AppColors.white, size: 50),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                // Provider.of<CouponProvider>(context, listen: false).removeCouponData(true);
                // Provider.of<CartProvider>(context, listen: false).removeFromCart(cartIndex);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimens.paddingExtraSmall,
                  horizontal: AppDimens.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
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
                                image:
                                    '${_configNotifier.config.value!.baseUrls.productImageUrl}/${cart.product.image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  AppAssets.images.placeholderImage,
                                  height: 70,
                                  width: 85,
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withValues(alpha: 0.6),
                                  ),
                                  child: Text(
                                    'not_available_now_break'.tr,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.rubikRegular.copyWith(color: Colors.white, fontSize: 8),
                                  ),
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
                                cart.product.name,
                                style: AppTextStyles.rubikMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              RatingBar(
                                rating: cart.product.rating.isNotEmpty
                                    ? double.parse(cart.product.rating[0].average)
                                    : 0.0,
                                size: 12,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Flexible(
                                    child: Obx(
                                      () => Text(
                                        PriceConverter.convertPrice(
                                          price: cart.discountedPrice,
                                          config: _configNotifier.config.value,
                                        ),
                                        style: AppTextStyles.rubikBold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimens.paddingExtraSmall),
                                  RenderConditional(
                                    conditional: cart.discountAmount > 0,
                                    widget1: Flexible(
                                      child: Obx(
                                        () => Text(
                                          PriceConverter.convertPrice(
                                            price: cart.discountedPrice + cart.discountAmount,
                                            config: _configNotifier.config.value,
                                          ),
                                          style: AppTextStyles.rubikBold.copyWith(
                                            color: AppColors.grey,
                                            fontSize: AppDimens.fontSizeSmall,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ),
                                    widget2: SizedBox(),
                                  ),
                                ],
                              ),
                              RenderConditional(
                                conditional: cart.product.variations.isNotEmpty,
                                widget1: Padding(
                                  padding: EdgeInsets.only(top: AppDimens.paddingExtraSmall),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: MarqueText(
                                          backDuration: Duration(microseconds: 500),
                                          animationDuration: Duration(microseconds: 500),
                                          direction: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                '${'variation'.tr}: ',
                                                style: AppTextStyles.poppinsRegular.copyWith(
                                                  fontSize: AppDimens.fontSizeSmall,
                                                ),
                                              ),

                                              Text(
                                                variationText,
                                                style: AppTextStyles.poppinsRegular.copyWith(
                                                  fontSize: AppDimens.fontSizeSmall,
                                                  color: Theme.of(context).disabledColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                widget2: SizedBox(),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.getBackground(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // Provider.of<CouponProvider>(context, listen: false).removeCouponData(true);
                                  // if (cart.quantity > 1) {
                                  //   Provider.of<CartProvider>(context, listen: false).setQuantity(
                                  //     isIncrement: false,
                                  //     fromProductView: false,
                                  //     cart: cart,
                                  //     productIndex: null,
                                  //   );
                                  // } else {
                                  //   Provider.of<CartProvider>(context, listen: false).removeFromCart(cartIndex);
                                  // }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppDimens.paddingSmall,
                                    vertical: AppDimens.paddingExtraSmall,
                                  ),
                                  child: Icon(Icons.remove, size: 20),
                                ),
                              ),
                              Text(
                                cart.quantity.toString(),
                                style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeExtraLarge),
                              ),
                              InkWell(
                                onTap: () {
                                  // Provider.of<CouponProvider>(context, listen: false).removeCouponData(true);
                                  // Provider.of<CartProvider>(context, listen: false).setQuantity(
                                  //   isIncrement: true,
                                  //   fromProductView: false,
                                  //   cart: cart,
                                  //   productIndex: null,
                                  // );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppDimens.paddingSmall,
                                    vertical: AppDimens.paddingExtraSmall,
                                  ),
                                  child: Icon(Icons.add, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    RenderConditional(
                      conditional: addOns.isNotEmpty,
                      widget1: SizedBox(
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: AppDimens.paddingSmall),
                          itemCount: addOns.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: AppDimens.paddingSmall),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Provider.of<CartProvider>(
                                      //   context,
                                      //   listen: false,
                                      // ).removeAddOn(cartIndex, index);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2),
                                      child: Icon(Icons.remove_circle, color: Theme.of(context).primaryColor, size: 18),
                                    ),
                                  ),
                                  Text(addOns[index].name, style: AppTextStyles.rubikRegular),
                                  SizedBox(width: 2),
                                  Obx(
                                    () => Text(
                                      PriceConverter.convertPrice(
                                        price: addOns[index].price,
                                        config: _configNotifier.config.value,
                                      ),
                                      style: AppTextStyles.rubikMedium,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text('(${cart.addOnIds[index].quantity})', style: AppTextStyles.rubikRegular),
                                ],
                              ),
                            );
                          },
                        ),
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
  }
}
