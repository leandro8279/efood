import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_phone_request.g.dart';

@JsonSerializable()
class const VerifyPhoneRequest({
  required final String phone,
  required final String token,
}) extends Equatable {
  factory VerifyPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPhoneRequestToJson(this);

  @override
  List<Object?> get props => [phone, token];

  @override
  bool? get stringify => false;
}
