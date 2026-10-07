import 'package:equatable/equatable.dart';

class const AuthSession({required final String token}) extends Equatable {
  @override
  List<Object?> get props => [token];

  @override
  bool? get stringify => false;
}
