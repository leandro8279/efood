import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_message_api_model.g.dart';

@JsonSerializable()
class const AuthMessageApiModel({required final String message})
    extends Equatable {
  factory AuthMessageApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthMessageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthMessageApiModelToJson(this);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;
}
