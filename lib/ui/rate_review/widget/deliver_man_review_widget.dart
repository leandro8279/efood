import 'package:efood/domain/models/order/delivery_man.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const DeliverManReviewWidget({super.key, final DeliveryMan? deliveryMan, required final String orderID})
    extends StatefulWidget {
  @override
  State<DeliverManReviewWidget> createState() => _DeliverManReviewWidgetState();
}

class _DeliverManReviewWidgetState extends State<DeliverManReviewWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimens.paddingSmall),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: SizedBox(
                    width: 1170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.deliveryMan != null ? DeliveryManWidget(deliveryMan: widget.deliveryMan) : SizedBox(),
                        SizedBox(height: AppDimens.paddingLarge),

                        Container(
                          padding: EdgeInsets.all(AppDimens.paddingSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'rate_his_service'.tr,
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
                                        true // productProvider.deliveryManRating < (i + 1)
                                            ? Icons.star_border
                                            : Icons.star,
                                        size: 25,
                                        color:
                                            true // productProvider.deliveryManRating < (i + 1)
                                            ? AppColors.getGreyColor()
                                            : Theme.of(context).primaryColor,
                                      ),
                                      onTap: () {
                                        // if (!Provider.of<ProductProvider>(context, listen: false).isReviewSubmitted) {
                                        //   Provider.of<ProductProvider>(context, listen: false).setDeliveryManRating(i + 1);
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
                                maxLines: 5,
                                capitalization: TextCapitalization.sentences,
                                controller: _controller,
                                hintText: 'write_your_review_here'.tr,
                                fillColor: AppColors.getSearchBg(),
                              ),
                              SizedBox(height: 40),

                              // Submit button
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
                                child: Column(
                                  children: [
                                    RenderConditional(
                                      conditional: true, // !productProvider.isLoading
                                      widget1: CustomButton(
                                        btnTxt:
                                            true // productProvider.isReviewSubmitted
                                            ? 'submitted'
                                            : 'submit'.tr,
                                        onTap:
                                            true // productProvider.isReviewSubmitted
                                            ? null
                                            : () {
                                                // if (productProvider.deliveryManRating == 0) {
                                                //   showCustomSnackBar('Give a rating'.tr;
                                                // } else if (_controller.text.isEmpty) {
                                                //   showCustomSnackBar('Write a review'.tr;
                                                // } else {
                                                //   FocusScopeNode currentFocus = FocusScope.of(context);
                                                //   if (!currentFocus.hasPrimaryFocus) {
                                                //     currentFocus.unfocus();
                                                //   }
                                                //   ReviewBody reviewBody = ReviewBody(
                                                //     deliveryManId: widget.deliveryMan.id.toString(),
                                                //     rating: productProvider.deliveryManRating.toString(),
                                                //     comment: _controller.text,
                                                //     orderId: widget.orderID,
                                                //   );
                                                //   productProvider.submitDeliveryManReview(reviewBody, context).then((value) {
                                                //     if (value.isSuccess) {
                                                //       showCustomSnackBar(value.message, context, isError: false);
                                                //       _controller.text = '';
                                                //     } else {
                                                //       showCustomSnackBar(value.message, context);
                                                //     }
                                                //   });
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
                        ),
                      ],
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
