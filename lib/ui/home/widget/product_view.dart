import 'package:efood/config/constants.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/home/widget/product_card_shimmer.dart';
import 'package:efood/ui/home/widget/product_widget_web.dart';
import 'package:efood/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const ProductView({
  super.key,
  required final bool isLoading,
  required final Config? config,
  required final int latestOffset,
  required final int latestPageSize,
  required final List<Product> products,
  required final ProductType productType,
  final ScrollController? scrollController,
  final void Function()? reloadLatestProductList,
  final void Function(int value)? setLatestOffset,
}) extends StatefulWidget {
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(covariant ProductView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_handleScroll);
      widget.scrollController?.addListener(_handleScroll);
    }
  }

  void _handleScroll() {
    final controller = widget.scrollController;
    if (widget.productType != ProductType.latestProduct ||
        controller == null ||
        !controller.hasClients ||
        controller.position.pixels != controller.position.maxScrollExtent ||
        widget.products.isEmpty ||
        widget.isLoading) {
      return;
    }

    final pageCount = (widget.latestPageSize / AppConstants.productsPageLimit).ceil();
    if (widget.latestOffset < pageCount) {
      widget.setLatestOffset?.call(widget.latestOffset + 1);
      widget.reloadLatestProductList?.call();
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading;
    final config = widget.config;
    final latestOffset = widget.latestOffset;
    final latestPageSize = widget.latestPageSize;
    final products = widget.products;
    final productType = widget.productType;

    if (isLoading) {
      return RenderConditional(
        conditional: productType == ProductType.popularProduct,
        widget1: SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 195,
                child: ProductWidgetShimmer(products: products),
              );
            },
          ),
        ),
        widget2: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 4,
            crossAxisCount: 1,
          ),
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            return ProductShimmer(isEnabled: products.isEmpty);
          },
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
        ),
      );
    }

    if (products.isEmpty) {
      return SizedBox();
    }

    return RenderConditional(
      conditional: productType == ProductType.popularProduct,
      widget1: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 195,
              child: ProductWidgetWeb(product: products[index], fromPopularItem: true, config: config),
            );
          },
        ),
      ),
      widget2: Column(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 3.5,
              crossAxisCount: 1,
            ),
            itemCount: products.length,
            padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraSmall),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(product: products[index], config: config);
            },
          ),
          SizedBox(height: 30),

          RenderConditional(
            conditional: products.isNotEmpty,
            widget1: Padding(
              padding: .all(0),
              child: RenderConditional(
                conditional: ResponsiveHelper.isDesktop(context),
                widget1: RenderConditional(
                  conditional: isLoading,
                  widget1: Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  widget2: RenderConditional(
                    conditional: (latestOffset == (latestPageSize / AppConstants.productsPageLimit).ceil()),
                    widget1: SizedBox(),
                    widget2: SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.getBackground(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          // _productProvider.moreProduct(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'see_more'.tr,
                            style: AppTextStyles.poppinsRegular.copyWith(fontSize: AppDimens.fontSizeOverLarge),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                widget2: RenderConditional(
                  conditional: isLoading,
                  widget1: Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  widget2: SizedBox.shrink(),
                ),
              ),
            ),
            widget2: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
