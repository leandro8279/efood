import 'package:efood/domain/models/order/delivery_man.dart';
import 'package:efood/domain/models/order/order_details.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/rate_review/widget/deliver_man_review_widget.dart';
import 'package:efood/ui/rate_review/widget/product_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const RateReviewScreen({
  super.key,
  required final List<OrderDetails> orderDetailsList,
  final DeliveryMan? deliveryMan,
}) extends StatefulWidget {
  @override
  State<RateReviewScreen> createState() => _RateReviewScreenState();
}

class _RateReviewScreenState extends State<RateReviewScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.deliveryMan == null ? 1 : 2, initialIndex: 0, vsync: this);
    // Provider.of<ProductProvider>(context, listen: false).initRatingData(widget.orderDetailsList);
    // Provider.of<ProductProvider>(context, listen: false).updateSubmitted(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'rate_review'.tr),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 1170,
              color: Theme.of(context).cardColor,
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                labelColor: AppTextStyles.bodyText1().color,
                indicatorColor: Theme.of(context).primaryColor,
                unselectedLabelStyle: AppTextStyles.rubikRegular.copyWith(
                  color: AppColors.hint,
                  fontSize: AppDimens.fontSizeSmall,
                ),
                labelStyle: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeSmall),
                tabs: widget.deliveryMan != null
                    ? [
                        Tab(text: widget.orderDetailsList.length > 1 ? 'items' : 'item'.tr),
                        Tab(text: 'delivery_man'.tr),
                      ]
                    : [Tab(text: widget.orderDetailsList.length > 1 ? 'items' : 'item'.tr)],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.deliveryMan != null
                  ? [
                      ProductReviewWidget(orderDetailsList: widget.orderDetailsList),
                      DeliverManReviewWidget(
                        deliveryMan: widget.deliveryMan,
                        orderID: widget.orderDetailsList[0].orderId.toString(),
                      ),
                    ]
                  : [ProductReviewWidget(orderDetailsList: widget.orderDetailsList)],
            ),
          ),
        ],
      ),
    );
  }
}
