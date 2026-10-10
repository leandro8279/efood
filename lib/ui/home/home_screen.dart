import 'package:efood/config/constants.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/home/home_viewmodel.dart';
import 'package:efood/ui/home/widget/banner_view.dart';
import 'package:efood/ui/home/widget/category_view.dart';
import 'package:efood/ui/home/widget/set_menu_view.dart';
import 'package:efood/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen({super.key, required final HomeViewModel viewModel, required final bool result})
    extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerGlobalKey,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: AppColors.getBackground(),
      // drawer: ResponsiveHelper.isTab(context) ? Drawer(child: OptionsView(onTap: null)) : SizedBox(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          backgroundColor: AppColors.getBackground(),
          child: Stack(
            children: [
              _scrollView(_scrollController, context),
              RenderConditional(
                conditional: true, //!splashProvider.isRestaurantOpenNow(context)
                widget1: Positioned(
                  bottom: AppDimens.paddingExtraSmall,
                  left: 0,
                  right: 0,
                  child: RenderConditional(
                    conditional: false, //  orderProvider.isRestaurantCloseShow
                    widget1: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingExtraSmall),
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
                            child: Text(
                              'restaurant_is_close_now'.tr,
                              style: AppTextStyles.rubikRegular.copyWith(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // orderProvider.changeStatus(false, notify: true)
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                              child: Icon(Icons.cancel_outlined, color: Colors.white, size: AppDimens.paddingLarge),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget2: SizedBox(),
                  ),
                ),
                widget2: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scrollbar _scrollView(ScrollController _scrollController, BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).cardColor,
            pinned: ResponsiveHelper.isTab(context) ? true : false,
            leading: RenderConditional(
              conditional: ResponsiveHelper.isTab(context),
              widget1: IconButton(
                onPressed: () => drawerGlobalKey.currentState!.openDrawer(),
                icon: Icon(Icons.menu, color: Colors.black),
              ),
              widget2: SizedBox.shrink(),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.images.logo, width: 40, height: 40),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppConstants.appName,
                    style: AppTextStyles.rubikBold.copyWith(color: Theme.of(context).primaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            actions: [
              IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, Routes.getNotificationRoute())
                },
                icon: Icon(Icons.notifications, color: AppTextStyles.bodyText1().color),
              ),

              RenderConditional(
                conditional: ResponsiveHelper.isTab(context),
                widget1: IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, Routes.getDashboardRoute('cart'))
                  },
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.shopping_cart, color: AppTextStyles.bodyText1().color),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                          child: Center(
                            child: Text(
                              'cartList.length.toString()',
                              style: AppTextStyles.rubikMedium.copyWith(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget2: SizedBox(),
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverDelegate(
              child: Center(
                child: InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.getSearchRoute())
                  },
                  child: Container(
                    height: 60,
                    width: 1170,
                    color: Theme.of(context).cardColor,
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.getSearchBg(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                            child: Icon(Icons.search, size: 25),
                          ),
                          Expanded(
                            child: Text(
                              'search_items_here'.tr,
                              style: AppTextStyles.rubikRegular.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 1170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => CategoryView(categories: viewModel.categories, config: viewModel.config)),
                        SetMenuView(),

                        BannerView(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: TitleWidget(
                            title: 'popular_item'.tr,
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.getPopularItemScreen());
                            },
                          ),
                        ),
                        // ProductView(productType: ProductType.POPULAR_PRODUCT),

                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: TitleWidget(title: 'latest_item'.tr),
                        ),
                        // ProductView(productType: ProductType.LATEST_PRODUCT, scrollController: _scrollController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverDelegate({required final Widget child}) extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 60 || oldDelegate.minExtent != 60 || child != oldDelegate.child;
  }
}
