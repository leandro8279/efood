import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/coupon/coupon_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'coupon_api.g.dart';

@RestApi()
abstract class CouponApi {
  factory CouponApi(Dio dio) = _CouponApi;

  @GET(AppConstants.couponListUrl)
  Future<List<CouponApiModel>> getCouponList();
}
