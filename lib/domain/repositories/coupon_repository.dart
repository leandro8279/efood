import 'package:efood/domain/models/coupon/coupon.dart';
import 'package:efood/utils/result.dart';

abstract interface class CouponRepository {
  Future<Result<List<Coupon>>> getCouponList();
}
