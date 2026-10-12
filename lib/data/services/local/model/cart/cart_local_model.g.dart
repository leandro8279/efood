// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartLocalModel _$CartLocalModelFromJson(
  Map<String, dynamic> json,
) => CartLocalModel(
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  taxAmount: (json['tax_amount'] as num).toDouble(),
  discountAmount: (json['discount_amount'] as num).toDouble(),
  discountedPrice: (json['discounted_price'] as num).toDouble(),
  product: ProductLocalModel.fromJson(json['product'] as Map<String, dynamic>),
  addOnIds: (json['add_on_ids'] as List<dynamic>)
      .map((e) => CartAddOnLocalModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  variation: (json['variation'] as List<dynamic>)
      .map(
        (e) => e == null
            ? null
            : ProductVariationLocalModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$CartLocalModelToJson(CartLocalModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'quantity': instance.quantity,
      'tax_amount': instance.taxAmount,
      'discount_amount': instance.discountAmount,
      'discounted_price': instance.discountedPrice,
      'product': instance.product.toJson(),
      'add_on_ids': instance.addOnIds.map((e) => e.toJson()).toList(),
      'variation': instance.variation.map((e) => e?.toJson()).toList(),
    };
