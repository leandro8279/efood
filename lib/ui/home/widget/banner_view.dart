import 'package:efood/domain/models/banner/banner.dart' as banner_model;
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class const BannerView({
  super.key,
  required final bool isLoading,
  required final Config? config,
  required final List<banner_model.Banner> banners,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TitleWidget(title: 'banner'.tr),
        ),

        SizedBox(
          height: 85,
          child: RenderConditional(
            conditional: !isLoading,
            widget1: RenderConditional(
              conditional: banners.isNotEmpty,
              widget1: ListView.builder(
                itemCount: banners.length,
                padding: EdgeInsets.only(left: AppDimens.paddingSmall),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: AppDimens.paddingSmall),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                            blurRadius: Get.isDarkMode ? 2 : 5,
                            spreadRadius: Get.isDarkMode ? 0 : 1,
                          ),
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: AppAssets.images.placeholderBanner,
                          width: 250,
                          height: 85,
                          fit: BoxFit.cover,
                          image: config != null ? '${config!.baseUrls.bannerImageUrl}/${banners[index].image}' : '',
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            AppAssets.images.placeholderBanner,
                            width: 250,
                            height: 85,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              widget2: Center(child: Text('no_banner_available'.tr)),
            ),
            widget2: BannerShimmer(banners: banners),
          ),
        ),
      ],
    );
  }
}

class const BannerShimmer({super.key, required final List<banner_model.Banner> banners}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: EdgeInsets.only(left: AppDimens.paddingSmall),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer(
          duration: Duration(seconds: 2),
          enabled: banners.isEmpty,
          child: Container(
            width: 250,
            height: 85,
            margin: EdgeInsets.only(right: AppDimens.paddingSmall),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                  blurRadius: Get.isDarkMode ? 2 : 5,
                  spreadRadius: Get.isDarkMode ? 0 : 1,
                ),
              ],
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
