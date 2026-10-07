import 'package:dio/dio.dart';
import 'package:efood/data/repositories/auth/auth_repository.dart';
import 'package:efood/data/services/api/auth_api.dart';
import 'package:efood/data/services/api/mappers/auth_register_api_model_mapper.dart';
import 'package:efood/data/services/api/mappers/auth_session_api_model_mapper.dart';
import 'package:efood/data/services/api/mappers/dio_exception_mapper.dart';
import 'package:efood/data/services/api/model/auth/request/forget_password_request.dart';
import 'package:efood/data/services/api/model/auth/request/login_request.dart';
import 'package:efood/data/services/api/model/auth/request/register_request.dart';
import 'package:efood/domain/models/auth/auth_register.dart';
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

  @override
  Future<Result<AuthRegister>> register({
    required String fName,
    required String lName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authApi.register(
        RegisterRequest(email: email, fName: fName, lName: lName, phone: phone, password: password),
      );

      return Result.ok(result.toDomain());
    } on DioException catch (e, st) {
      // if (e.response?.statusCode == 401) {
      //   return Result.error(InvalidCredentialsException(cause: e, stackTrace: st));
      // }
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<void>> forgetPassword(String email) async {
    try {
      await _authApi.forgetPassword(ForgetPasswordRequest(email: email, emailOrPhone: email));

      return Result.ok(null);
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 403) {
        return Result.error(ForbiddenException(cause: e, stackTrace: st));
      }
      if (e.response?.statusCode == 404) {
        return Result.error(NotFoundException(cause: e, stackTrace: st));
      }
      return Result.error(e.toAppException(st));
    }
  }
}
