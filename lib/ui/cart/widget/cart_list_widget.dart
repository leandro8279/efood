import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/ui/cart/widget/cart_product_widget.dart';
import 'package:flutter/material.dart';

class const CartListWidget({
  super.key,
  required final List<Cart> carts,
  required final List<bool> availableList,
  required final List<List<ProductAddOn>> addOns,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: carts.length,
      itemBuilder: (context, index) {
        return CartProductWidget(cart: carts[index], cartIndex: index, addOns: addOns[index], isAvailable: availableList[index]);
      },
    );
  }
}
