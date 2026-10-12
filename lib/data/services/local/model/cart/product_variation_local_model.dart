import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_variation_local_model.g.dart';

@JsonSerializable()
class const ProductVariationLocalModel({required final String type, required final double price}) extends Equatable {
  factory ProductVariationLocalModel.fromJson(Map<String, dynamic> json) => _$ProductVariationLocalModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariationLocalModelToJson(this);

  @override
  List<Object?> get props => [type, price];
}
