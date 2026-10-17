import 'package:efood/domain/models/product/product.dart';
import 'package:equatable/equatable.dart';

class const OrderDetails({
  required final int id,
  required final int productId,
  required final int orderId,
  required final double price,
  required final Product productDetails,
  required final List<ProductVariation> variations,
  required final ProductVariation variation,
  required final double discountOnProduct,
  required final String discountType,
  required final int quantity,
  required final double taxAmount,
  required final String createdAt,
  required final String updatedAt,
  required final List<int> addOnIds,
  final List<int>? addOnQtys,
}) extends Equatable {
  @override
  List<Object?> get props => [
    id,
    productId,
    orderId,
    price,
    productDetails,
    variations,
    variation,
    discountOnProduct,
    discountType,
    quantity,
    taxAmount,
    createdAt,
    updatedAt,
    addOnIds,
    addOnQtys,
  ];
}
