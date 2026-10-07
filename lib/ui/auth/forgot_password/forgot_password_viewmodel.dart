import 'package:efood/data/repositories/auth/auth_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class ForgotPasswordViewModel({required final AuthRepository _authRepository}) extends GetxController {
  late final forgot = Command1<void, String>(_forgotPassword);

  Future<Result<void>> _forgotPassword(String emailOrPhone) async {
    print(emailOrPhone);
    final result = await _authRepository.forgetPassword(emailOrPhone);

    switch (result) {
      case Ok<void>():
        print("SUCESSO");
        return Result.done;
      case Error<void>(:final error):
        print(error.toString());
        return Result.error(error);
    }
  }
}
