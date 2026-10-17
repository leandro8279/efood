import 'package:efood/domain/models/category/category.dart';
import 'package:efood/ui/category/category_viewmodel.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class const CategoryScreen({super.key, required final Category category, required final CategoryViewModel viewModel})
    extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with TickerProviderStateMixin {
  late int tabIndex = 0;
  late String type = 'all';
  ConfigNotifier get configNotifier => Get.find<ConfigNotifier>();

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async {
    widget.viewModel.loadCategories.execute();
    widget.viewModel.loadSubCategories.execute(widget.category.id.toString());
    widget.viewModel.loadCategoryProductList.execute(
      CategoryProductListParams(categoryId: widget.category.id.toString(), type: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final config = configNotifier.config;

    return Scaffold(
      body: RenderConditional(
        conditional: widget.viewModel.isLoading,
        widget1: categoryShimmer(context, height),
        widget2: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).cardColor,
              expandedHeight: 200,
              toolbarHeight: 50 + MediaQuery.of(context).padding.top,
              pinned: true,
              floating: false,
              leading: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: IconButton(
                  icon: Icon(Icons.chevron_left, color: AppColors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              flexibleSpace: Container(
                color: Theme.of(context).canvasColor,
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: MediaQuery.of(context).size.width,
                child: FlexibleSpaceBar(
                  title: Text(
                    widget.category.name,
                    style: AppTextStyles.rubikMedium.copyWith(
                      fontSize: AppDimens.fontSizeLarge,
                      color: AppColors.getWhiteAndBlack(),
                    ),
                  ),
                  titlePadding: EdgeInsets.only(
                    bottom: 54 + (MediaQuery.of(context).padding.top / 2),
                    left: 50,
                    right: 50,
                  ),
                  background: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 50),
                    child: FadeInImage.assetNetwork(
                      placeholder: AppAssets.images.placeholderRectangle,
                      fit: BoxFit.cover,
                      image: config.value != null
                          ? '${config.value!.baseUrls.categoryBannerImageUrl}/${widget.category.bannerImage!.isNotEmpty ? widget.category.bannerImage : ''}'
                          : '',
                      imageErrorBuilder: (c, o, s) =>
                          Image.asset(AppAssets.images.placeholderRectangle, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: RenderConditional(
                  conditional: widget.viewModel.subCategories.isNotEmpty,
                  widget1: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).cardColor,
                    child: TabBar(
                      controller: TabController(
                        initialIndex: tabIndex,
                        length: widget.viewModel.subCategories.length + 1,
                        vsync: this,
                      ),
                      isScrollable: true,
                      unselectedLabelColor: AppColors.getGreyColor(),
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: AppTextStyles.bodyText1().color,
                      tabs: _tabs(),
                      onTap: (int index) {
                        type = 'all';
                        tabIndex = index;
                        if (index == 0) {
                          widget.viewModel.loadCategoryProductList.execute(
                            CategoryProductListParams(categoryId: widget.category.id.toString()),
                          );
                        } else {
                          widget.viewModel.loadCategoryProductList.execute(
                            CategoryProductListParams(
                              categoryId: widget.viewModel.subCategories[index - 1].id.toString(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  widget2: SizedBox(),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FilterButtonWidget(
                    type: type,
                    items: widget.viewModel.productTypeList,
                    onSelected: (selected) {
                      type = selected;
                      widget.viewModel.loadCategoryProductList.execute(
                        CategoryProductListParams(categoryId: widget.viewModel.selectedSubCategoryId, type: type),
                      );
                    },
                  ),

                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: height < 600 ? height : height - 600),
                    child: SizedBox(
                      width: 1170,
                      child: RenderConditional(
                        conditional: widget.viewModel.loadCategoryProductList.running.value,
                        widget1: RenderConditional(
                          conditional: widget.viewModel.categoryProducts.isNotEmpty,
                          widget1: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 13,
                              childAspectRatio: 4,
                              crossAxisCount: 1,
                            ),
                            itemCount: widget.viewModel.categoryProducts.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(AppDimens.paddingSmall),
                            itemBuilder: (context, index) {
                              return ProductWidget(product: widget.viewModel.categoryProducts[index]);
                            },
                          ),
                          widget2: NoDataScreen(isFooter: false),
                        ),
                        widget2: GridView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(AppDimens.paddingSmall),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 4,
                            crossAxisCount: 1,
                          ),
                          itemBuilder: (context, index) {
                            return ProductShimmer(isEnabled: widget.viewModel.categoryProducts.isEmpty);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Tab> _tabs() {
    List<Tab> tabList = [];
    tabList.add(Tab(text: 'All'));
    for (var subCategory in widget.viewModel.subCategories) {
      tabList.add(Tab(text: subCategory.name));
    }
    return tabList;
  }

  SingleChildScrollView categoryShimmer(BuildContext context, double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: height < 600 ? height : height - 400),
            child: Center(
              child: SizedBox(
                width: 1170,
                child: Column(
                  children: [
                    Shimmer(
                      duration: Duration(seconds: 2),
                      enabled: true,
                      child: Container(height: 200, width: double.infinity, color: Colors.grey[300]),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 4,
                        crossAxisCount: 1,
                      ),
                      itemBuilder: (context, index) {
                        return ProductShimmer(isEnabled: widget.viewModel.categoryProducts.isEmpty);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
