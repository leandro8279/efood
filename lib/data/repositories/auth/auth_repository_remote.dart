import 'package:dio/dio.dart';
import 'package:efood/data/repositories/auth/auth_repository.dart';
import 'package:efood/data/services/api/auth_api.dart';
import 'package:efood/data/services/api/mappers/auth_session_api_model_mapper.dart';
import 'package:efood/data/services/api/mappers/dio_exception_mapper.dart';
import 'package:efood/data/services/api/model/login/login_request.dart';
import 'package:efood/domain/models/auth/auth_session.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';

class AuthRepositoryRemote({required final AuthApi _authApi}) implements AuthRepository {
  @override
  Future<Result<AuthSession>> login({String? emailOrPhone, required String type, required String password}) async {
    try {
      final session = await _authApi.login(LoginRequest(type: type, password: password, emailOrPhone: emailOrPhone));

      return Result.ok(session.toDomain());
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 401) {
        return Result.error(InvalidCredentialsException(cause: e, stackTrace: st));
      }
      return Result.error(e.toAppException(st));
    }
  }
}
