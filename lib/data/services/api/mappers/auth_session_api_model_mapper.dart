import 'package:efood/data/services/api/model/auth/auth_session_api_model.dart';
import 'package:efood/domain/models/auth/auth_session.dart';

extension AuthSessionApiModelMapper on AuthSessionApiModel {
  AuthSession toDomain() => AuthSession(token: token);
}
