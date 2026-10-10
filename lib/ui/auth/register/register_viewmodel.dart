import 'package:efood/domain/models/auth/auth_register.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

typedef RegisterForm = ({String fName, String lName, String phone, String email, String password});

class RegisterViewModel({
  required final AuthRepository _authRepository,
  required final ConfigNotifier _configNotifier,
}) extends GetxController {
  late final register = Command1<AuthRegister, RegisterForm>(_register);

  bool get emailVerification => _configNotifier.requireConfig.emailVerification;

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
