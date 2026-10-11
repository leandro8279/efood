import 'package:efood/ui/core/share/rating_bar.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class const ProductShimmer({super.key, required final bool isEnabled}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: EdgeInsets.symmetric(vertical: AppDimens.paddingExtraSmall, horizontal: AppDimens.paddingSmall),
      margin: EdgeInsets.only(bottom: AppDimens.paddingDefault),
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
      child: Shimmer(
        duration: Duration(seconds: 2),
        enabled: isEnabled,
        child: Row(
          children: [
            Container(
              height: 70,
              width: 85,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
            ),
            SizedBox(width: AppDimens.paddingSmall),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 15, width: double.maxFinite, color: Colors.grey[300]),
                  SizedBox(height: 5),
                  RatingBar(rating: 0.0, size: 12),
                  SizedBox(height: 10),
                  Container(height: 10, width: 50, color: Colors.grey[300]),
                ],
              ),
            ),
            SizedBox(width: 10),

            Column(
              children: [
                Icon(Icons.favorite_border, color: Colors.grey),
                Expanded(child: SizedBox()),
                Icon(Icons.add, color: AppColors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
