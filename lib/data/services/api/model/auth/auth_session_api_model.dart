import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth_session_api_model.g.dart';

@JsonSerializable()
class const AuthSessionApiModel({required final String token}) extends Equatable {
  factory AuthSessionApiModel.fromJson(Map<String, dynamic> json) => _$AuthSessionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSessionApiModelToJson(this);

  @override
  List<Object?> get props => [token];
}
