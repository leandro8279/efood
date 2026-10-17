import 'package:efood/domain/models/order/order_details.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const ProductReviewWidget({super.key, required final List<OrderDetails> orderDetailsList})
    extends StatelessWidget {
  ConfigNotifier get _configNotifier => Get.find<ConfigNotifier>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: SizedBox(
                    width: 1170,
                    child: ListView.builder(
                      itemCount: orderDetailsList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(AppDimens.paddingSmall),
                          margin: EdgeInsets.only(bottom: AppDimens.paddingSmall),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(AppDimens.paddingSmall),
                          ),
                          child: Column(
                            children: [
                              // Product details
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: AppAssets.images.placeholderImage,
                                      height: 70,
                                      width: 85,
                                      fit: BoxFit.cover,
                                      image:
                                          '${_configNotifier.config.value!.baseUrls.productImageUrl}/${orderDetailsList[index].productDetails.image}',
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        AppAssets.images.placeholderImage,
                                        height: 70,
                                        width: 85,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimens.paddingSmall),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          orderDetailsList[index].productDetails.name,
                                          style: AppTextStyles.rubikMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          PriceConverter.convertPrice(
                                            config: _configNotifier.config.value,
                                            price: orderDetailsList[index].productDetails.price,
                                          ),
                                          style: AppTextStyles.rubikBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${'quantity'.tr}: ',
                                        style: AppTextStyles.rubikMedium.copyWith(
                                          color: AppColors.getGreyBunkerColor(),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        orderDetailsList[index].quantity.toString(),
                                        style: AppTextStyles.rubikMedium.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: AppDimens.fontSizeSmall,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(height: 20),

                              // Rate
                              Text(
                                'rate_the_food'.tr,
                                style: AppTextStyles.rubikMedium.copyWith(color: AppColors.getGreyBunkerColor()),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: AppDimens.paddingSmall),
                              SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                      child: Icon(
                                        true // productProvider.ratingList[index] < (i + 1)
                                            ? Icons.star_border
                                            : Icons.star,
                                        size: 25,
                                        color:
                                            true // productProvider.ratingList[index] < (i + 1)
                                            ? AppColors.getGreyColor()
                                            : Theme.of(context).primaryColor,
                                      ),
                                      onTap: () {
                                        // if(!productProvider.submitList[index]) {
                                        //   Provider.of<ProductProvider>(context, listen: false).setRating(index, i + 1);
                                        // }
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: AppDimens.paddingLarge),
                              Text(
                                'share_your_opinion'.tr,
                                style: AppTextStyles.rubikMedium.copyWith(color: AppColors.getGreyBunkerColor()),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),
                              CustomTextField(
                                maxLines: 3,
                                capitalization: TextCapitalization.sentences,
                                isEnabled: true, //  !productProvider.submitList[index],
                                hintText: 'write_your_review_here'.tr,
                                fillColor: AppColors.getSearchBg(),
                                onChanged: (text) {
                                  // productProvider.setReview(index, text);
                                },
                              ),
                              SizedBox(height: 20),

                              // Submit button
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
                                child: Column(
                                  children: [
                                    RenderConditional(
                                      conditional: true, //   !productProvider.loadingList[index]
                                      widget1: CustomButton(
                                        btnTxt:
                                            true // productProvider.submitList[index]
                                            ? 'submitted'
                                            : 'submit'.tr,
                                        backgroundColor:
                                            true // productProvider.submitList[index]
                                            ? AppColors.getGreyColor()
                                            : Theme.of(context).primaryColor,
                                        onTap: () {
                                          // if(!productProvider.submitList[index]) {
                                          //   if (productProvider.ratingList[index] == 0) {
                                          //     showCustomSnackBar('Give a rating'.tr;
                                          //   } else if (productProvider.reviewList[index].isEmpty) {
                                          //     showCustomSnackBar('Write a review'.tr;
                                          //   } else {
                                          //     FocusScopeNode currentFocus = FocusScope.of(context);
                                          //     if (!currentFocus.hasPrimaryFocus) {
                                          //       currentFocus.unfocus();
                                          //     }
                                          //     ReviewBody reviewBody = ReviewBody(
                                          //       productId: orderDetailsList[index].productId.toString(),
                                          //       rating: productProvider.ratingList[index].toString(),
                                          //       comment: productProvider.reviewList[index],
                                          //       orderId: orderDetailsList[index].orderId.toString(),
                                          //     );
                                          //     productProvider.submitReview(index, reviewBody).then((value) {
                                          //       if (value.isSuccess) {
                                          //         showCustomSnackBar(value.message, context, isError: false);
                                          //         productProvider.setReview(index, '');
                                          //       } else {
                                          //         showCustomSnackBar(value.message, context);
                                          //       }
                                          //     });
                                          //   }
                                          // }
                                        },
                                      ),
                                      widget2: Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
