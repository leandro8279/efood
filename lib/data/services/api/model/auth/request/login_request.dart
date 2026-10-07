import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class const LoginRequest({final String? emailOrPhone, required final String type, required final String password})
    extends Equatable {
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [emailOrPhone, type, password];

  @override
  bool? get stringify => false;
}
