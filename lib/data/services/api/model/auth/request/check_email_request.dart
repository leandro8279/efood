import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_email_request.g.dart';

@JsonSerializable()
class const CheckEmailRequest({required final String email}) extends Equatable {
  factory CheckEmailRequest.fromJson(Map<String, dynamic> json) => _$CheckEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckEmailRequestToJson(this);

  @override
  List<Object?> get props => [email];

  @override
  bool? get stringify => false;
}
