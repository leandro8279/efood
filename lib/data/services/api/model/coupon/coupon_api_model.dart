import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon_api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class const CouponApiModel({
  required final int id,
  required final String title,
  required final String code,
  required final String startDate,
  required final String expireDate,
  required final double minPurchase,
  required final double maxDiscount,
  required final double discount,
  required final String discountType,
  required final int status,
  required final String createdAt,
  required final String updatedAt,
  required final String couponType,
  required final int? limit,
}) extends Equatable {
  factory CouponApiModel.fromJson(Map<String, dynamic> json) => _$CouponApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponApiModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    code,
    startDate,
    expireDate,
    minPurchase,
    maxDiscount,
    discount,
    discountType,
    status,
    createdAt,
    updatedAt,
    couponType,
    limit,
  ];
}
