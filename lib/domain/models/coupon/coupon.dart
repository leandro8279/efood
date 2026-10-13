import 'package:equatable/equatable.dart';

class const Coupon({
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
