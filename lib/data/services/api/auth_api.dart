import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/interceptors/auth_interceptor.dart';
import 'package:efood/data/services/api/model/auth/request/requests.dart';
import 'package:efood/data/services/api/model/auth/response/auth_register_api_model.dart';
import 'package:efood/data/services/api/model/auth/response/auth_check_status_api_model.dart';
import 'package:efood/data/services/api/model/auth/response/auth_message_api_model.dart';
import 'package:efood/data/services/api/model/auth/response/auth_session_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(AppConstants.loginUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthSessionApiModel> login(@Body() LoginRequest request);

  @POST(AppConstants.registerUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthRegisterApiModel> register(@Body() RegisterRequest request);

  @POST(AppConstants.checkEmailUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthCheckStatusApiModel> checkEmail(@Body() CheckEmailRequest request);

  @POST(AppConstants.checkPhoneUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthCheckStatusApiModel> checkPhone(@Body() CheckPhoneRequest request);

  @POST(AppConstants.forgetUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<dynamic> forgetPassword(@Body() ForgetPasswordRequest request);

  @POST(AppConstants.verifyEmailUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthMessageApiModel> verifyEmail(@Body() VerifyEmailRequest request);

  @POST(AppConstants.verifyPhoneUrl)
  @Extra(AuthInterceptor.publicRoute)
  Future<AuthMessageApiModel> verifyPhone(@Body() VerifyPhoneRequest request);
}
