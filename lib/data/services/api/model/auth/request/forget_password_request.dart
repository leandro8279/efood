import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class const ForgetPasswordRequest({required final String emailOrPhone, required final String email}) extends Equatable {
  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ForgetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);

  @override
  List<Object?> get props => [emailOrPhone, email];

  @override
  bool? get stringify => false;
}
