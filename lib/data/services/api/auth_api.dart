import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/interceptors/auth_interceptor.dart';
import 'package:efood/data/services/api/model/auth/auth_session_api_model.dart';
import 'package:efood/data/services/api/model/login/login_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(AppConstants.loginUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthSessionApiModel> login(@Body() LoginRequest request);
}
