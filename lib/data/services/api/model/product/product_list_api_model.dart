import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class const ProductListApiModel({
  required final int totalSize,
  required final int limit,
  required final int offset,
  required final List<ProductApiModel> products,
}) extends Equatable {
  factory ProductListApiModel.fromJson(Map<String, dynamic> json) => _$ProductListApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListApiModelToJson(this);

  @override
  List<Object?> get props => [totalSize, limit, offset, products];
}
