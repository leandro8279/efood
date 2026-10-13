import 'package:efood/data/services/api/model/coupon/coupon_api_model.dart';
import 'package:efood/domain/models/coupon/coupon.dart';

extension CouponApiModelMapper on CouponApiModel {
  Coupon toDomain() => Coupon(
    id: id,
    title: title,
    code: code,
    startDate: startDate,
    expireDate: expireDate,
    minPurchase: minPurchase,
    maxDiscount: maxDiscount,
    discount: discount,
    discountType: discountType,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
    couponType: couponType,
    limit: limit,
  );
}
