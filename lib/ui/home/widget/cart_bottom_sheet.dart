import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/share/wish_button.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/notifiers/cart_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/date_converter.dart';
import 'package:efood/utils/notifiers/product_notifier.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class const CartBottomSheet({
  super.key,
  required final Product product,
  required final bool fromSetMenu,
  required final Function callback,
  required final Cart cart,
  required final int cartIndex,
  required final bool fromCart,
}) extends StatefulWidget {
  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  late int cartIndex;
  final CartNotifier cartNotifier = Get.find<CartNotifier>();
  final ConfigNotifier configNotifier = Get.find<ConfigNotifier>();
  final ProductNotifier productNotifier = Get.find<ProductNotifier>();

  @override
  void initState() {
    productNotifier.initData(widget.product, widget.cart);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductVariation variation = ProductVariation(price: 0, type: '');

    return Stack(
      children: [
        Container(
          width: 600,
          padding: EdgeInsets.all(AppDimens.paddingDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Obx(() {
            double? endingPrice;
            double? startingPrice;
            //  cartNotifier.setCartUpdate(false);

            if (widget.product.choiceOptions.isNotEmpty) {
              List<double> priceList = [];
              for (var variation in widget.product.variations) {
                priceList.add(variation.price);
              }

              priceList.sort((a, b) => a.compareTo(b));
              startingPrice = priceList[0];
              if (priceList[0] < priceList[priceList.length - 1]) {
                endingPrice = priceList[priceList.length - 1];
              }
            } else {
              startingPrice = widget.product.price;
            }
            List<String> variationList = [];
            for (int index = 0; index < widget.product.choiceOptions.length; index++) {
              variationList.add(
                widget.product.choiceOptions[index]!.options[productNotifier.variationIndex[index]].replaceAll(' ', ''),
              );
            }
            String variationType = '';

            bool isFirst = true;

            for (var variation in variationList) {
              if (isFirst) {
                variationType = '$variationType$variation';
                isFirst = false;
              } else {
                variationType = '$variationType-$variation';
              }
            }

            double price = widget.product.price;
            for (ProductVariation variation in widget.product.variations) {
              if (variation.type == variationType) {
                price = variation.price;
                variation = variation;
                break;
              }
            }
            double priceWithDiscount = PriceConverter.convertWithDiscount(
              price: price,
              discount: widget.product.discount,
              discountType: widget.product.discountType,
            );
            double addonsCost = 0;
            List<CartAddOn> addOnIdList = [];
            for (int index = 0; index < widget.product.addOns.length; index++) {
              if (productNotifier.addOnActiveList[index]) {
                addonsCost = addonsCost + (widget.product.addOns[index].price * productNotifier.addOnQtyList[index]);
                addOnIdList.add(
                  CartAddOn(id: widget.product.addOns[index].id, quantity: productNotifier.addOnQtyList[index]),
                );
              }
            }

            DateTime currentTime = DateTime.now();
            DateTime start = DateFormat('hh:mm:ss').parse(widget.product.availableTimeStarts);
            DateTime end = DateFormat('hh:mm:ss').parse(widget.product.availableTimeEnds);
            DateTime startTime = DateTime(
              currentTime.year,
              currentTime.month,
              currentTime.day,
              start.hour,
              start.minute,
              start.second,
            );
            DateTime endTime = DateTime(
              currentTime.year,
              currentTime.month,
              currentTime.day,
              end.hour,
              end.minute,
              end.second,
            );
            if (endTime.isBefore(startTime)) {
              endTime = endTime.add(Duration(days: 1));
            }
            bool isAvailable = currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
            Cart cartModel = Cart(
              price: price,
              discountedPrice: priceWithDiscount,
              variation: [variation],
              discountAmount:
                  (price -
                  PriceConverter.convertWithDiscount(
                    price: price,
                    discount: widget.product.discount,
                    discountType: widget.product.discountType,
                  )),
              quantity: productNotifier.quantity.value,
              taxAmount:
                  price -
                  PriceConverter.convertWithDiscount(
                    price: price,
                    discount: widget.product.tax,
                    discountType: widget.product.taxType,
                  ),
              addOnIds: addOnIdList,
              product: widget.product,
            );

            cartIndex = cartNotifier.isExistInCart(
              widget.product.id,
              variationType.isEmpty ? '' : variationType,
              false,
              null,
            );
            // print('is exit : $_cartIndex');

            double priceWithQuantity = priceWithDiscount * productNotifier.quantity.value;
            double priceWithAddons = priceWithQuantity + addonsCost;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Product
                    _productView(context, startingPrice, endingPrice, price, priceWithDiscount, cartModel),
                    SizedBox(height: AppDimens.paddingLarge),

                    // Quantity
                    Column(
                      children: [
                        _quantityView(context, cartModel),
                        SizedBox(height: AppDimens.paddingLarge),
                      ],
                    ),

                    // Variation
                    _variationView(variationType),
                    RenderConditional(
                      conditional: widget.product.choiceOptions.isNotEmpty,
                      widget1: SizedBox(height: AppDimens.paddingLarge),
                      widget2: SizedBox(),
                    ),

                    _description(context),

                    // Addons
                    _addonsView(context),

                    Row(
                      children: [
                        Text(
                          '${'total_amount'.tr}:',
                          style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                        ),
                        SizedBox(width: AppDimens.paddingExtraSmall),
                        Obx(
                          () => Text(
                            PriceConverter.convertPrice(config: configNotifier.config.value, price: priceWithAddons),
                            style: AppTextStyles.rubikBold.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: AppDimens.fontSizeLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimens.paddingLarge),
                    //Add to cart Button
                    _cartButton(isAvailable, context, cartModel),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _addonsView(BuildContext context) {
    return RenderConditional(
      conditional: widget.product.addOns.isNotEmpty,
      widget1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('addons'.tr, style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge)),
          SizedBox(height: AppDimens.paddingExtraSmall),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: (1 / 1.1),
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.product.addOns.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // if (!productProvider.addOnActiveList[index]) {
                  //   productProvider.addAddOn(true, index);
                  // } else if (productProvider.addOnQtyList[index] == 1) {
                  //   productProvider.addAddOn(false, index);
                  // }
                },

                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    bottom:
                        true // productProvider.addOnActiveList[index]
                        ? 2
                        : 20,
                  ),
                  decoration: BoxDecoration(
                    color:
                        true // productProvider.addOnActiveList[index]
                        ? Theme.of(context).primaryColor
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow:
                        true // productProvider.addOnActiveList[index]
                        ? [
                            BoxShadow(
                              color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                              blurRadius: Get.isDarkMode ? 2 : 5,
                              spreadRadius: Get.isDarkMode ? 0 : 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.product.addOns[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.rubikMedium.copyWith(
                                color:
                                    true // productProvider.addOnActiveList[index]
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: AppDimens.fontSizeSmall,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              PriceConverter.convertPrice(
                                config: configNotifier.config.value,
                                price: widget.product.addOns[index].price,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.rubikRegular.copyWith(
                                color:
                                    true // productProvider.addOnActiveList[index]
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: AppDimens.fontSizeExtraSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RenderConditional(
                        conditional: true, //  productProvider.addOnActiveList[index]
                        widget1: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // if (productProvider.addOnQtyList[index] > 1) {
                                    //   productProvider.setAddOnQuantity(false, index);
                                    // } else {
                                    //   productProvider.addAddOn(false, index);
                                    // }
                                  },
                                  child: Center(child: Icon(Icons.remove, size: 15)),
                                ),
                              ),
                              Text(
                                '', // productProvider.addOnQtyList[index].toString(),
                                style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeSmall),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // productProvider.setAddOnQuantity(true, index)
                                  },
                                  child: Center(child: Icon(Icons.add, size: 15)),
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
              );
            },
          ),
          SizedBox(height: AppDimens.paddingExtraSmall),
        ],
      ),
      widget2: SizedBox(),
    );
  }

  Widget _quantityView(BuildContext context, Cart cartModel) {
    return Row(
      children: [
        Text('quantity'.tr, style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge)),
        Expanded(child: SizedBox()),
        _quantityButton(context, cartModel),
      ],
    );
  }

  Widget _variationView(String variationType) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.product.choiceOptions.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.choiceOptions[index]!.title,
              style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
            ),
            SizedBox(height: AppDimens.paddingExtraSmall),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                childAspectRatio: (1 / 0.25),
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.product.choiceOptions[index]!.options.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    // productProvider.setCartVariationIndex(index, i, widget.product, variationType, context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraSmall),
                    decoration: BoxDecoration(
                      color:
                          true // productProvider.variationIndex[index] != i
                          ? AppColors.background
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.product.choiceOptions[index]!.options[i].trim(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.rubikRegular.copyWith(
                        color:
                            true // productProvider.variationIndex[index] != i
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: index != widget.product.choiceOptions.length - 1 ? AppDimens.paddingLarge : 0),
          ],
        );
      },
    );
  }

  Widget _description(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('description'.tr, style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge)),
        SizedBox(height: AppDimens.paddingExtraSmall),

        Align(
          alignment: Alignment.topLeft,
          child: ReadMoreText(
            widget.product.description,
            trimLines: 2,
            trimCollapsedText: 'show_more'.tr,
            trimExpandedText: 'show_less'.tr,
            moreStyle: AppTextStyles.robotoRegular.copyWith(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              fontSize: AppDimens.fontSizeExtraSmall,
            ),
            lessStyle: AppTextStyles.robotoRegular.copyWith(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              fontSize: AppDimens.fontSizeExtraSmall,
            ),
          ),
        ),
        SizedBox(height: AppDimens.paddingLarge),
      ],
    );
  }

  Widget _productView(
    BuildContext context,
    double startingPrice,
    double? endingPrice,
    double price,
    double priceWithDiscount,
    Cart cartModel,
  ) {
    final productImageUrl = configNotifier.config.value?.baseUrls.productImageUrl ?? '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: AppAssets.images.placeholderRectangle,
            image: '$productImageUrl/${widget.product.image}',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            imageErrorBuilder: (c, o, s) {
              return Image.asset(AppAssets.images.placeholderRectangle, width: 100, height: 100, fit: BoxFit.cover);
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeLarge),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar(
                    rating: widget.product.rating.isNotEmpty ? double.parse(widget.product.rating[0]!.average) : 0.0,
                    size: 15,
                  ),
                  VegTagView(product: widget.product),
                ],
              ),
              SizedBox(height: 20),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(
                            '${PriceConverter.convertPrice(price: startingPrice, discount: widget.product.discount, discountType: widget.product.discountType, config: configNotifier.config.value)}'
                            '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, discount: widget.product.discount, discountType: widget.product.discountType, config: configNotifier.config.value)}' : ''}',

                            style: AppTextStyles.rubikMedium.copyWith(
                              fontSize: AppDimens.fontSizeLarge,
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).primaryColor,
                            ),
                            maxLines: 1,
                          ),
                        ),

                        price > priceWithDiscount
                            ? FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${PriceConverter.convertPrice(price: startingPrice, config: configNotifier.config.value)}'
                                    '${endingPrice != null ? ' - ${PriceConverter.convertPrice(price: endingPrice, config: configNotifier.config.value)}' : ''}',
                                    style: AppTextStyles.rubikMedium.copyWith(
                                      color: AppColors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  WishButton(product: widget.product),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cartButton(bool isAvailable, BuildContext context, Cart cartModel) {
    return Column(
      children: [
        RenderConditional(
          conditional: isAvailable,
          widget1: SizedBox(),
          widget2: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppDimens.paddingSmall),
            margin: EdgeInsets.only(bottom: AppDimens.paddingSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: Column(
              children: [
                Text(
                  'not_available_now'.tr,
                  style: AppTextStyles.rubikMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: AppDimens.fontSizeLarge,
                  ),
                ),
                Text(
                  '${'available_will_be'.tr} ${DateConverter.convertTimeToTime(time: widget.product.availableTimeStarts)} '
                  '- ${DateConverter.convertTimeToTime(time: widget.product.availableTimeEnds)}',
                  style: AppTextStyles.rubikRegular,
                ),
              ],
            ),
          ),
        ),

        CustomButton(
          btnTxt: cartIndex != -1 ? 'update_in_cart' : 'add_to_cart'.tr,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.pop(context);
            cartNotifier.addToCart(cartModel, cartIndex);
          },
        ),
      ],
    );
  }

  Widget _quantityButton(BuildContext context, Cart cartModel) {
    // final productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          InkWell(
            onTap: () => null, //  productProvider.quantity > 1 ? productProvider.setQuantity(false) : null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall, vertical: AppDimens.paddingExtraSmall),
              child: Icon(Icons.remove, size: 20),
            ),
          ),
          Text(
            '', //  productProvider.quantity.toString(),
            style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeExtraSmall),
          ),

          InkWell(
            onTap: () {
              // productProvider.setQuantity(true)
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall, vertical: AppDimens.paddingExtraSmall),
              child: Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class const VegTagView({super.key, required final Product product}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackground(),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(blurRadius: 5, color: AppColors.getBackground().withOpacity(0.05))],
      ),

      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimens.paddingExtraSmall),
              child: Image.asset(AppAssets.images.getImageUrl('${product.productType}'), fit: BoxFit.fitHeight),
            ),
            SizedBox(width: AppDimens.paddingSmall),

            Text(
              '${product.productType}'.tr,
              style: AppTextStyles.robotoRegular.copyWith(fontSize: AppDimens.fontSizeSmall),
            ),
            SizedBox(width: AppDimens.paddingExtraSmall),
          ],
        ),
      ),
    );
  }
}
