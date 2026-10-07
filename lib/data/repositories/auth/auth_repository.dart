import 'package:efood/domain/models/auth/auth_register.dart';
import 'package:efood/domain/models/auth/auth_session.dart';
import 'package:efood/utils/result.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({String? emailOrPhone, required String type, required String password});
  Future<Result<AuthRegister>> register({
    required String fName,
    required String lName,
    required String phone,
    required String email,
    required String password,
  });
  Future<Result<void>> forgetPassword(String email);
}
