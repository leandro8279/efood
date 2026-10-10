import 'package:efood/domain/models/product/product.dart';
import 'package:equatable/equatable.dart';

class const Cart({
  required final double price,
  required final double discountedPrice,
  required final List<Object?> variation,
  required final double discountAmount,
  required final int quantity,
  required final double taxAmount,
  required final List<CartAddOn> addOnIds,
  required final Product product,
}) extends Equatable {
  @override
  List<Object?> get props => [
    price,
    discountedPrice,
    variation,
    discountAmount,
    quantity,
    taxAmount,
    addOnIds,
    product,
  ];
}

class const CartAddOn({required final int id, required final int quantity}) extends Equatable {
  @override
  List<Object?> get props => [id, quantity];
}
