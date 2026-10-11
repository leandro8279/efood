import 'package:efood/domain/models/product/product.dart';
import 'package:flutter/material.dart';

class const WishButton({
  super.key,
  required final Product product,
  final EdgeInsetsGeometry edgeInset = EdgeInsets.zero,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
        //   List<int> productIdList = [];
        //   productIdList.add(product.id);

        //   wishList.wishIdList.contains(product.id)
        //       ? wishList.removeFromWishList(product, context)
        //       : wishList.addToWishList(product, context);
        // } else {
        //   showCustomSnackBar('now_you_are_in_guest_mode'.tr, context);
        // }
      },
      child: Padding(
        padding: edgeInset,
        child: Icon(
          // wishList.wishIdList.contains(product.id) ? Icons.favorite : Icons.favorite_border,
          [].contains(product.id) ? Icons.favorite : Icons.favorite_border,
          color: [].contains(product.id)
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }
}
