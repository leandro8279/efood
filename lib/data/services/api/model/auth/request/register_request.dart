import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest({
  required final String lName,
  required final String fName,
  required final String phone,
  required final String email,
  required final String password,
}) extends Equatable {
  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  List<Object?> get props => [fName, lName, phone, email, password];

  @override
  bool? get stringify => false;
}
