import 'package:efood/data/services/api/model/auth/response/auth_check_email_api_model.dart';
import 'package:efood/domain/models/auth/auth_check_email.dart';
import 'package:efood/domain/models/auth/token_status.dart';

extension AuthCheckEmailApiModelMapper on AuthCheckEmailApiModel {
  AuthCheckEmail toDomain() => AuthCheckEmail(token: TokenStatus.values.byName(token));
}
