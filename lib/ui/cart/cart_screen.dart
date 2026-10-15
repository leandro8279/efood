import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController couponController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // Provider.of<CouponProvider>(context, listen: false).removeCouponData(false);
    // Provider.of<OrderProvider>(context, listen: false).setOrderType(
    //   Provider.of<SplashProvider>(context, listen: false).configModel.homeDelivery ? 'delivery' : 'take_away',
    //   notify: false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(context: context, title: 'my_cart'.tr),
      body: Obx(
        () => RenderConditional(
          conditional: true, //cart.cartList.length > 0
          widget1: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(AppDimens.paddingSmall),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: height < 600 ? height : height - 400),
                              child: SizedBox(
                                width: 1170,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(0),
                                        padding: EdgeInsets.all(0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Product
                                            //  CartListWidget(cart: cart,addOns: _addOnsList, availableList: _availableList),

                                            // Coupon
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: couponController,
                                                    style: AppTextStyles.rubikRegular,
                                                    decoration: InputDecoration(
                                                      hintText: 'enter_promo_code'.tr,
                                                      hintStyle: AppTextStyles.rubikRegular.copyWith(
                                                        color: AppColors.getHintColor(),
                                                      ),
                                                      isDense: true,
                                                      filled: true,
                                                      enabled: coupon.discount == 0,
                                                      fillColor: Theme.of(context).cardColor,
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.horizontal(
                                                          left: Radius.circular(
                                                            true //isLtr
                                                                ? 10
                                                                : 0,
                                                          ),
                                                          right: Radius.circular(
                                                            true //isLtr
                                                                ? 0
                                                                : 10,
                                                          ),
                                                        ),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    // if(_couponController.text.isNotEmpty && !coupon.isLoading) {
                                                    //   if(coupon.discount < 1) {
                                                    //     coupon.applyCoupon(_couponController.text, _total).then((discount) {
                                                    //       if (discount > 0) {
                                                    //         showCustomSnackBar('You got ${PriceConverter.convertPrice(context, discount)} discount', context, isError: false);
                                                    //       } else {
                                                    //         showCustomSnackBar('invalid_code_or'.tr, context, isError: true);
                                                    //       }
                                                    //     });
                                                    //   } else {
                                                    //     coupon.removeCouponData(true);
                                                    //   }
                                                    // } else if(_couponController.text.isEmpty) {
                                                    //   showCustomSnackBar('enter_a_Coupon_code'.tr, context);
                                                    // }
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 100,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.horizontal(
                                                        left: Radius.circular(
                                                          true //isLtr
                                                              ? 0
                                                              : 10,
                                                        ),
                                                        right: Radius.circular(
                                                          true //isLtr
                                                              ? 10
                                                              : 0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: RenderConditional(
                                                      conditional: coupon.discount <= 0,
                                                      widget1: RenderConditional(
                                                        conditional: !coupon.isLoading,
                                                        widget1: Text(
                                                          'apply'.tr,
                                                          style: AppTextStyles.rubikMedium.copyWith(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        widget2: CircularProgressIndicator(
                                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                        ),
                                                      ),
                                                      widget2: Icon(Icons.clear, color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: AppDimens.paddingLarge),
                                            // Order type
                                            Text(
                                              'delivery_option'.tr,
                                              style: AppTextStyles.rubikMedium.copyWith(
                                                fontSize: AppDimens.fontSizeLarge,
                                              ),
                                            ),
                                            RenderConditional(
                                              conditional: true, // Provider.of<SplashProvider>(context, listen: false).configModel.homeDelivery
                                              widget1: DeliveryOptionButton(
                                                value: 'delivery',
                                                title: 'delivery'.tr,
                                                kmWiseFee: _kmWiseCharge,
                                              ),
                                              widget2: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: AppDimens.paddingSmall,
                                                  top: AppDimens.paddingLarge,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_circle_outline_sharp,
                                                      color: Theme.of(context).hintColor,
                                                    ),
                                                    SizedBox(width: AppDimens.paddingExtraLarge),
                                                    Text(
                                                      'home_delivery_not_available'.tr,
                                                      style: TextStyle(
                                                        fontSize: AppDimens.fontSizeDefault,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            RenderConditional(
                                              conditional: true, // Provider.of<SplashProvider>(context, listen: false).configModel.selfPickup
                                              widget1: DeliveryOptionButton(
                                                value: 'take_away',
                                                title: 'take_away'.tr,
                                                kmWiseFee: _kmWiseCharge,
                                              ),
                                              widget2: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: AppDimens.paddingSmall,
                                                  bottom: AppDimens.paddingLarge,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_circle_outline_sharp,
                                                      color: Theme.of(context).hintColor,
                                                    ),
                                                    SizedBox(width: AppDimens.paddingExtraLarge),
                                                    Text(
                                                      'self_pickup_not_available'.tr,
                                                      style: TextStyle(
                                                        fontSize: AppDimens.fontSizeDefault,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // Total
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'items_price'.tr,
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                                Text(
                                                  PriceConverter.convertPrice(price: itemPrice),
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'tax'.tr,
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                                Text(
                                                  '(+) ${PriceConverter.convertPrice(price: tax)}',
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'addons'.tr,
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                                Text(
                                                  '(+) ${PriceConverter.convertPrice(price: addOns)}',
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'discount'.tr,
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                                Text(
                                                  '(-) ${PriceConverter.convertPrice(price: discount)}',
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'coupon_discount'.tr,
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                                Text(
                                                  '(-) ${PriceConverter.convertPrice(price: Provider.of<CouponProvider>(context).discount)}',
                                                  style: AppTextStyles.rubikRegular.copyWith(
                                                    fontSize: AppDimens.fontSizeLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            RenderConditional(
                                              conditional: true, //_kmWiseCharge
                                              widget1: SizedBox(),
                                              widget2: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'delivery_fee'.tr,
                                                    style: AppTextStyles.rubikRegular.copyWith(
                                                      fontSize: AppDimens.fontSizeLarge,
                                                    ),
                                                  ),
                                                  Text(
                                                    '(+) ${PriceConverter.convertPrice(price: deliveryCharge)}',
                                                    style: AppTextStyles.rubikRegular.copyWith(
                                                      fontSize: AppDimens.fontSizeLarge,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
                                              child: CustomDivider(),
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  kmWiseCharge ? 'subtotal' : 'total_amount'.tr,
                                                  style: AppTextStyles.rubikMedium.copyWith(
                                                    fontSize: AppDimens.fontSizeExtraLarge,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  PriceConverter.convertPrice(price: total),
                                                  style: AppTextStyles.rubikMedium.copyWith(
                                                    fontSize: AppDimens.fontSizeExtraLarge,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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

              Container(
                width: 1170,
                padding: EdgeInsets.all(AppDimens.paddingSmall),
                child: CustomButton(
                  btnTxt: 'continue_checkout'.tr,
                  onTap: () {
                    // if(_orderAmount < Provider.of<SplashProvider>(context, listen: false).configModel.minimumOrderValue) {
                    //   showCustomSnackBar('Minimum order amount is ${PriceConverter.convertPrice(context, Provider.of<SplashProvider>(context, listen: false).configModel
                    //       .minimumOrderValue)}, you have ${PriceConverter.convertPrice(context, _orderAmount)} in your cart, please add more item.'.tr;
                    // } else {
                    //  Navigator.pushNamed(context, Routes.getCheckoutRoute(
                    //    _total, 'cart', Provider.of<OrderProvider>(context, listen: false).orderType,
                    //    Provider.of<CouponProvider>(context, listen: false).code,
                    //  ));
                    // }
                  },
                ),
              ),
            ],
          ),
          widget2: NoDataScreen(isCart: true),
        ),
      ),
    );
  }
}
