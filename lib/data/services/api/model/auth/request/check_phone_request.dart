import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_phone_request.g.dart';

@JsonSerializable()
class const CheckPhoneRequest({required final String phone}) extends Equatable {
  factory CheckPhoneRequest.fromJson(Map<String, dynamic> json) => _$CheckPhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPhoneRequestToJson(this);

  @override
  List<Object?> get props => [phone];

  @override
  bool? get stringify => false;
}
