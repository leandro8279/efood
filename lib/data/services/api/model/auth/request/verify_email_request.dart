import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request.g.dart';

@JsonSerializable()
class const VerifyEmailRequest({
  required final String email,
  required final String token,
}) extends Equatable {
  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);

  @override
  List<Object?> get props => [email, token];

  @override
  bool? get stringify => false;
}
