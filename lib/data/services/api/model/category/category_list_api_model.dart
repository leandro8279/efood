import 'package:equatable/equatable.dart';
import 'package:efood/data/services/api/model/category/category_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_list_api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class const CategoryListApiModel({
  required final int totalSize,
  required final int limit,
  required final int offset,
  required final List<CategoryApiModel> categories,
}) extends Equatable {
  factory CategoryListApiModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryListApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListApiModelToJson(this);

  @override
  List<Object?> get props => [totalSize, limit, offset, categories];
}
