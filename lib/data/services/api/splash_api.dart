import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/config/config_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'splash_api.g.dart';

@RestApi()
abstract class SplashApi {
  factory SplashApi(Dio dio) = _SplashApi;

  @GET(AppConstants.configUrl)
  Future<ConfigApiModel> getConfig();

  @GET(AppConstants.policyPage)
  Future<String> getPolicyPage();
}
