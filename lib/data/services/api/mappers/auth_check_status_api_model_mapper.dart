import 'package:efood/data/services/api/model/auth/response/auth_check_status_api_model.dart';
import 'package:efood/domain/models/auth/auth_check_status.dart';
import 'package:efood/domain/models/auth/token_status.dart';

extension AuthCheckStatusApiModelMapper on AuthCheckStatusApiModel {
  AuthCheckStatus toDomain() => AuthCheckStatus(token: TokenStatus.values.byName(token));
}
