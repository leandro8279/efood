import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth_register_api_model.g.dart';

@JsonSerializable()
class const AuthRegisterApiModel({required final String temporaryToken}) extends Equatable {
  factory AuthRegisterApiModel.fromJson(Map<String, dynamic> json) => _$AuthRegisterApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRegisterApiModelToJson(this);

  @override
  List<Object?> get props => [temporaryToken];
}
