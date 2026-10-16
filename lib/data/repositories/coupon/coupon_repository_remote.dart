import 'package:dio/dio.dart';
import 'package:efood/data/services/api/coupon_api.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/domain/models/coupon/coupon.dart';
import 'package:efood/domain/repositories/coupon_repository.dart';
import 'package:efood/utils/result.dart';

class CouponRepositoryRemote({required final CouponApi _couponApi}) implements CouponRepository {
  @override
  Future<Result<List<Coupon>>> getCouponList() async {
    try {
      final coupons = await _couponApi.getCouponList();
      return Result.ok(coupons.map((coupon) => coupon.toDomain()).toList());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<Coupon>> applyCoupon(String couponCode) async {
    try {
      final coupon = await _couponApi.applyCoupon(couponCode);
      return Result.ok(coupon.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
