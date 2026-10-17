import 'package:efood/config/constants.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/home/home_viewmodel.dart';
import 'package:efood/ui/home/widget/banner_view.dart';
import 'package:efood/ui/home/widget/category_view.dart';
import 'package:efood/ui/home/widget/product_view.dart';
import 'package:efood/ui/home/widget/set_menu_view.dart';
import 'package:efood/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const HomeScreen({super.key, required final HomeViewModel viewModel, required final bool result})
    extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerGlobalKey,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: AppColors.getBackground(),
      drawer: ResponsiveHelper.isTab(context) ? Text("Drawer 1") : Text("Drawer 2"),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          backgroundColor: AppColors.getBackground(),
          child: Stack(
            children: [
              _scrollView(_scrollController, context),
              Obx(
                () => RenderConditional(
                  conditional: widget.viewModel.config != null && !widget.viewModel.isRestaurantOpenNow(),
                  widget1: Positioned(
                    bottom: AppDimens.paddingExtraSmall,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingExtraSmall),
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
                      child: Row(
                        children: [
                          Text(
                            'restaurant_is_close_now'.tr,
                            style: AppTextStyles.rubikRegular.copyWith(fontSize: 12, color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              //  orderProvider.changeStatus(false, notify: true)
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                              child: Icon(Icons.cancel_outlined, color: Colors.white, size: AppDimens.paddingLarge),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget2: const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scrollbar _scrollView(ScrollController scrollController, BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: CustomScrollView(
        controller: scrollController,
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
                        Obx(
                          () => CategoryView(
                            config: widget.viewModel.config,
                            categories: widget.viewModel.categories,
                            isLoading: widget.viewModel.loadCategories.running.value,
                          ),
                        ),
                        Obx(
                          () => SetMenuView(
                            config: widget.viewModel.config,
                            setMenuProducts: widget.viewModel.setMenuProducts,
                            isLoading: widget.viewModel.loadSetMenu.running.value,
                          ),
                        ),

                        Obx(
                          () => BannerView(
                            config: widget.viewModel.config,
                            banners: widget.viewModel.banners,
                            isLoading: widget.viewModel.loadBanners.running.value,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: TitleWidget(
                            title: 'popular_item'.tr,
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.getPopularItemScreen());
                            },
                          ),
                        ),
                        Obx(
                          () => ProductView(
                            config: widget.viewModel.config,
                            latestOffset: widget.viewModel.popularOffset,
                            productType: ProductType.popularProduct,
                            latestPageSize: widget.viewModel.popularPageSize,
                            products: widget.viewModel.popularProductList.toList(),
                            isLoading: widget.viewModel.loadPopularProductList.running.value,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: TitleWidget(title: 'latest_item'.tr),
                        ),
                        Obx(
                          () => ProductView(
                            config: widget.viewModel.config,
                            latestOffset: widget.viewModel.latestOffset,
                            latestPageSize: widget.viewModel.latestPageSize,
                            products: widget.viewModel.latestProducts.toList(),
                            setLatestOffset: widget.viewModel.setLatestOffset,
                            isLoading: widget.viewModel.loadLatestProductList.running.value,
                            reloadLatestProductList: () {
                              widget.viewModel.loadLatestProductList.execute((
                                false,
                                widget.viewModel.latestOffset.toString(),
                              ));
                            },
                            scrollController: scrollController,
                            productType: ProductType.latestProduct,
                          ),
                        ),
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
