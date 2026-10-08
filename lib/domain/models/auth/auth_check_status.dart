import 'package:efood/domain/models/auth/token_status.dart';
import 'package:equatable/equatable.dart';

class const AuthCheckStatus({required final TokenStatus token}) extends Equatable {
  @override
  List<Object?> get props => [token];

  @override
  bool? get stringify => false;
}
