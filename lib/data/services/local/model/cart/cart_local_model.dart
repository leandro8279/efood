import 'package:efood/data/services/local/model/cart/cart_add_on_local_model.dart';
import 'package:efood/data/services/local/model/cart/product_local_model.dart';
import 'package:efood/data/services/local/model/cart/product_variation_local_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_local_model.g.dart';

@JsonSerializable()
class const CartLocalModel({
  required final double price,
  required final int quantity,
  required final double taxAmount,
  required final double discountAmount,
  required final double discountedPrice,
  required final ProductLocalModel product,
  required final List<CartAddOnLocalModel> addOnIds,
  required final List<ProductVariationLocalModel?> variation,
}) extends Equatable {
  factory CartLocalModel.fromJson(Map<String, dynamic> json) => _$CartLocalModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartLocalModelToJson(this);

  @override
  List<Object?> get props => [price, discountAmount, variation, discountAmount, quantity, taxAmount, addOnIds, product];
}
