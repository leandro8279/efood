import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/home/home_viewmodel.dart';
import 'package:efood/ui/popular_item/popular_item_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const PopularItemScreen({super.key, required final PopularItemViewModel viewModel}) extends StatefulWidget {
  @override
  State<PopularItemScreen> createState() => _PopularItemScreenState();
}

class _PopularItemScreenState extends State<PopularItemScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      widget.viewModel.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final PopularItemViewModel viewModel = widget.viewModel;

    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'popular_item'.tr),
      body: Column(
        children: [
          Obx(
            () => IgnorePointer(
              ignoring: viewModel.products.isEmpty,
              child: FilterButtonWidget(
                type: viewModel.type,
                items: viewModel.productTypeList,
                onSelected: (selected) {
                  viewModel.setType(selected);
                  viewModel.loadProducts.execute(PopularProductListParams(reload: true, offset: '1', type: viewModel.type, isUpdate: true));
                },
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: RenderConditional(
                conditional: viewModel.loadProducts.running.value,
                widget1: RenderConditional(
                  conditional: viewModel.products.isNotEmpty,
                  widget1: RefreshIndicator(
                    onRefresh: () async {
                      viewModel.setType('all');
                      await viewModel.loadProducts.execute(PopularProductListParams(reload: true, offset: '1', type: viewModel.type));
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Center(
                          child: SizedBox(
                            width: 1170,
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 3.5,
                                crossAxisCount: 1,
                              ),
                              itemCount: viewModel.products.length,
                              padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraSmall),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductWidget(product: viewModel.products[index]);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget2: NoDataScreen(),
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
                    return ProductShimmer(isEnabled: viewModel.loadProducts.running.value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
