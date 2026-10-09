import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_message_api_model.g.dart';

@JsonSerializable()
class const ProfileMessageApiModel({required final String message}) extends Equatable {
  factory ProfileMessageApiModel.fromJson(Map<String, dynamic> json) => _$ProfileMessageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileMessageApiModelToJson(this);

  @override
  List<Object?> get props => [message];
}
