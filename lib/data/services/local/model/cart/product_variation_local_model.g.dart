// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variation_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariationLocalModel _$ProductVariationLocalModelFromJson(
  Map<String, dynamic> json,
) => ProductVariationLocalModel(
  type: json['type'] as String,
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$ProductVariationLocalModelToJson(
  ProductVariationLocalModel instance,
) => <String, dynamic>{'type': instance.type, 'price': instance.price};
