import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class const CategoryApiModel({
  required final int id,
  required final String name,
  required final int parentId,
  required final int position,
  required final int status,
  required final String createdAt,
  required final String updatedAt,
  required final String image,
  required final String? bannerImage,
}) extends Equatable {
  factory CategoryApiModel.fromJson(Map<String, dynamic> json) => _$CategoryApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryApiModelToJson(this);

  @override
  List<Object?> get props => [id, name, parentId, position, status, createdAt, updatedAt, image, bannerImage];
}
