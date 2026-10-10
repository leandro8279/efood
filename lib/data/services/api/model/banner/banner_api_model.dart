import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_api_model.g.dart';

@JsonSerializable()
class const BannerApiModel({
  required final int id,
  required final String title,
  required final String image,
  final int? productId,
  required final int status,
  required final String createdAt,
  required final String updatedAt,
  final int? categoryId,
}) extends Equatable {
  factory BannerApiModel.fromJson(Map<String, dynamic> json) => _$BannerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerApiModelToJson(this);

  @override
  List<Object?> get props => [id, title, image, productId, categoryId, status, createdAt, updatedAt];
}
