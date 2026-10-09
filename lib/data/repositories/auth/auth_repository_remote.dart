import 'package:dio/dio.dart';
import 'package:efood/data/services/api/auth_api.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/model/auth/request/requests.dart';
import 'package:efood/domain/models/auth/auth_register.dart';
import 'package:efood/domain/models/auth/auth_check_status.dart';
import 'package:efood/domain/models/auth/auth_session.dart';
import 'package:efood/domain/repositories/auth_repository.dart';
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
  Future<Result<AuthCheckStatus>> checkEmail(String email) async {
    try {
      final result = await _authApi.checkEmail(CheckEmailRequest(email: email));
      return Result.ok(result.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<AuthCheckStatus>> checkPhone(String phone) async {
    try {
      final result = await _authApi.checkPhone(CheckPhoneRequest(phone: phone));
      return Result.ok(result.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<void>> verifyEmail({
    required String email,
    required String token,
  }) async {
    try {
      await _authApi.verifyEmail(
        VerifyEmailRequest(email: email, token: token),
      );
      return Result.ok(null);
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 404) {
        return Result.error(InvalidOtpException(cause: e, stackTrace: st));
      }
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<void>> verifyPhone({
    required String phone,
    required String token,
  }) async {
    try {
      await _authApi.verifyPhone(
        VerifyPhoneRequest(phone: phone, token: token),
      );
      return Result.ok(null);
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 404) {
        return Result.error(InvalidOtpException(cause: e, stackTrace: st));
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
      if (e.response?.statusCode == 403) {
        return Result.error(EmailOrPhoneAlreadyInUseException(cause: e, stackTrace: st));
      }
      if ((e.response?.statusCode ?? 0) >= 500) {
        return Result.error(ServerException(cause: e, stackTrace: st));
      }
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
