import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/profile/profile_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio) = _ProfileApi;

  @GET(AppConstants.customerInfoUrl)
  Future<ProfileApiModel> getUserInfo();
}
