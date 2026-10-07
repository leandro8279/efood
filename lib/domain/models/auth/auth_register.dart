import 'package:equatable/equatable.dart';

class const AuthRegister({required final String temporaryToken}) extends Equatable {
  @override
  List<Object?> get props => [temporaryToken];

  @override
  bool? get stringify => false;
}
