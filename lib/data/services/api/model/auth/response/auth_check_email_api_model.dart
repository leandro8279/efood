import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_check_email_api_model.g.dart';

@JsonSerializable()
class const AuthCheckEmailApiModel({required final String token}) extends Equatable {
  factory AuthCheckEmailApiModel.fromJson(Map<String, dynamic> json) => _$AuthCheckEmailApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCheckEmailApiModelToJson(this);

  @override
  List<Object?> get props => [token];

  @override
  bool? get stringify => false;
}
