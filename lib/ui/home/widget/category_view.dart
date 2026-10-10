import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/app_dimens.dart';
import 'package:efood/ui/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class const CategoryView({super.key, required final List<Category> categories, required final Config? config})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
          child: TitleWidget(title: 'all_categories'.tr),
        ),

        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 80,
                child: RenderConditional(
                  conditional: categories.isNotEmpty,
                  widget1: RenderConditional(
                    conditional: categories.isNotEmpty,
                    widget1: ListView.builder(
                      itemCount: categories.length,
                      padding: EdgeInsets.only(left: AppDimens.paddingSmall),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final currentName = categories[index].name;
                        final name = currentName.length > 15 ? '${currentName.substring(0, 15)} ...' : currentName;
                        return Padding(
                          padding: EdgeInsets.only(right: AppDimens.paddingSmall),
                          child: InkWell(
                            onTap: () {
                              //  Navigator.pushNamed(context, Routes.getCategoryRoute(category.categoryList[index])),
                            },
                            child: Column(
                              children: [
                                ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: AppAssets.images.placeholderImage,
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                    image: config != null
                                        ? "${config!.baseUrls.categoryImageUrl}/${categories[index].image}"
                                        : "",
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                      AppAssets.images.placeholderImage,
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    ),
                                    // width: 100, height: 100, fit: BoxFit.cover,
                                  ),
                                ),

                                Flexible(
                                  child: Text(
                                    name,
                                    style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeSmall),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    widget2: Center(child: Text('no_category_available'.tr)),
                  ),
                  widget2: CategoryShimmer(categories: categories),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class const CategoryShimmer({super.key, required final List<Category> categories}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: AppDimens.paddingSmall),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: AppDimens.paddingSmall),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled: categories.isEmpty,
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                  ),
                  SizedBox(height: 5),
                  Container(height: 10, width: 50, color: Colors.grey[300]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class const CategoryAllShimmer({super.key, required final List<Category> categories}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(right: AppDimens.paddingSmall),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: false, // Provider.of<CategoryProvider>(context).categoryList == null,
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
              ),
              SizedBox(height: 5),
              Container(height: 10, width: 50, color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }
}
