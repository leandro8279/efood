// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponApiModel _$CouponApiModelFromJson(Map<String, dynamic> json) => CouponApiModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  code: json['code'] as String,
  startDate: json['start_date'] as String,
  expireDate: json['expire_date'] as String,
  minPurchase: (json['min_purchase'] as num).toDouble(),
  maxDiscount: (json['max_discount'] as num).toDouble(),
  discount: (json['discount'] as num).toDouble(),
  discountType: json['discount_type'] as String,
  status: (json['status'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  couponType: json['coupon_type'] as String,
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$CouponApiModelToJson(CouponApiModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'code': instance.code,
  'start_date': instance.startDate,
  'expire_date': instance.expireDate,
  'min_purchase': instance.minPurchase,
  'max_discount': instance.maxDiscount,
  'discount': instance.discount,
  'discount_type': instance.discountType,
  'status': instance.status,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'coupon_type': instance.couponType,
  'limit': instance.limit,
};
