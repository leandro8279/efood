import 'package:efood/data/services/api/model/auth/response/auth_register_api_model.dart';
import 'package:efood/domain/models/auth/auth_register.dart';

extension AuthRegisterApiModelMapper on AuthRegisterApiModel {
  AuthRegister toDomain() => AuthRegister(temporaryToken: temporaryToken);
}
