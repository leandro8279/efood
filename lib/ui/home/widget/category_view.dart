import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/app_dimens.dart';
import 'package:efood/ui/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryView extends StatelessWidget {
  const new({super.key});

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
                  conditional: true, //category.categoryList != null
                  widget1: RenderConditional(
                    conditional: true, //category.categoryList.length > 0
                    widget1: ListView.builder(
                      itemCount: 0, //category.categoryList.length,
                      padding: EdgeInsets.only(left: AppDimens.paddingSmall),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String _name = '';
                        // category.categoryList[index].name.length > 15
                        //     ? _name = category.categoryList[index].name.substring(0, 15) + ' ...'
                        //     : _name = category.categoryList[index].name;
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
                                    // image: Provider.of<SplashProvider>(context, listen: false).baseUrls != null
                                    //     ? '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/${category.categoryList[index].image}'
                                    //     : '',
                                    image: "",
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
                                    _name,
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
                  widget2: CategoryShimmer(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class const CategoryShimmer({super.key}) extends StatelessWidget {
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
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
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
