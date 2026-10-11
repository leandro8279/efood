import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/rating_bar.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class const ProductWidgetShimmer({super.key, required final List<Product> products}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppDimens.paddingSmall, bottom: AppDimens.paddingSmall),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
            blurRadius: Get.isDarkMode ? 2 : 5,
            spreadRadius: Get.isDarkMode ? 0 : 1,
          ),
        ],
      ),
      child: Shimmer(
        duration: Duration(seconds: 1),
        interval: Duration(seconds: 1),
        enabled: products.isEmpty,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 105,
              width: 195,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: Colors.grey[300],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppDimens.paddingSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingSmall,
                        vertical: AppDimens.paddingExtraSmall,
                      ),
                      child: Container(height: 15, color: Colors.grey[300]),
                    ),
                    RatingBar(rating: 0.0, size: AppDimens.paddingDefault),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingSmall,
                        vertical: AppDimens.paddingExtraSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: AppDimens.paddingSmall, width: 30, color: Colors.grey[300]),
                          SizedBox(width: AppDimens.paddingExtraSmall),
                          Container(height: AppDimens.paddingSmall, width: 30, color: Colors.grey[300]),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
                    ),
                    SizedBox(width: AppDimens.paddingExtraSmall),
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
