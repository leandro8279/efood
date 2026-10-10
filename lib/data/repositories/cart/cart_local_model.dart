import 'package:efood/data/services/api/mappers/product_api_model_mapper.dart';
import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';

class const CartLocalModel({
  required final double price,
  required final double discountedPrice,
  required final List<Object?> variation,
  required final double discountAmount,
  required final int quantity,
  required final double taxAmount,
  required final List<CartAddOn> addOnIds,
  required final Product product,
}) {
  factory CartLocalModel.fromJson(Map<String, dynamic> json) => CartLocalModel(
    price: (json['price'] as num).toDouble(),
    discountedPrice: (json['discounted_price'] as num).toDouble(),
    variation: (json['variation'] as List<dynamic>? ?? const []).cast<Object?>(),
    discountAmount: (json['discount_amount'] as num).toDouble(),
    quantity: (json['quantity'] as num).toInt(),
    taxAmount: (json['tax_amount'] as num).toDouble(),
    addOnIds: (json['add_on_ids'] as List<dynamic>? ?? const [])
        .map((addOn) => CartAddOn(id: (addOn['id'] as num).toInt(), quantity: (addOn['quantity'] as num).toInt()))
        .toList(),
    product: ProductApiModel.fromJson(json['product'] as Map<String, dynamic>).toDomain(),
  );

  factory CartLocalModel.fromDomain(Cart cart) => CartLocalModel(
    price: cart.price,
    discountedPrice: cart.discountedPrice,
    variation: cart.variation,
    discountAmount: cart.discountAmount,
    quantity: cart.quantity,
    taxAmount: cart.taxAmount,
    addOnIds: cart.addOnIds,
    product: cart.product,
  );

  Map<String, dynamic> toJson() => {
    'price': price,
    'discounted_price': discountedPrice,
    'variation': variation,
    'discount_amount': discountAmount,
    'quantity': quantity,
    'tax_amount': taxAmount,
    'add_on_ids': addOnIds.map((addOn) => {'id': addOn.id, 'quantity': addOn.quantity}).toList(),
    'product': product.toApiModel().toJson(),
  };

  Cart toDomain() => Cart(
    price: price,
    discountedPrice: discountedPrice,
    variation: variation,
    discountAmount: discountAmount,
    quantity: quantity,
    taxAmount: taxAmount,
    addOnIds: addOnIds,
    product: product,
  );
}
