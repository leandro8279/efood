import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/banner/banner_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'banner_api.g.dart';

@RestApi()
abstract class BannerApi {
  factory BannerApi(Dio dio) = _BannerApi;

  @GET(AppConstants.bannersUrl)
  Future<List<BannerApiModel>> getBanners();
}
