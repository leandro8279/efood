import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_check_status_api_model.g.dart';

@JsonSerializable()
class const AuthCheckStatusApiModel({required final String token}) extends Equatable {
  factory AuthCheckStatusApiModel.fromJson(Map<String, dynamic> json) => _$AuthCheckStatusApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCheckStatusApiModelToJson(this);

  @override
  List<Object?> get props => [token];

  @override
  bool? get stringify => false;
}
