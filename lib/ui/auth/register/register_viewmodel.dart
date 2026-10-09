import 'package:efood/domain/models/auth/auth_register.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

typedef RegisterForm = ({String fName, String lName, String phone, String email, String password});

class RegisterViewModel({
  required final AuthRepository _authRepository,
  required final ConfigRepository _configRepository,
}) extends GetxController {
  late final register = Command1<AuthRegister, RegisterForm>(_register);

  bool get emailVerification => _configRepository.config.emailVerification;

  Future<Result<AuthRegister>> _register(RegisterForm form) {
    return _authRepository.register(
      fName: form.fName,
      lName: form.lName,
      phone: form.phone,
      email: form.email,
      password: form.password,
    );
  }
}
