import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class const ProfileApiModel({
  required final int id,
  required final String fName,
  required final String lName,
  required final String email,
  required final String image,
  required final int isPhoneVerified,
  required final String emailVerifiedAt,
  required final String createdAt,
  required final String updatedAt,
  required final String emailVerificationToken,
  required final String phone,
  required final String cmFirebaseToken,
  required final double? point,
}) extends Equatable {
  factory ProfileApiModel.fromJson(Map<String, dynamic> json) => _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    fName,
    lName,
    email,
    image,
    isPhoneVerified,
    emailVerifiedAt,
    createdAt,
    updatedAt,
    emailVerificationToken,
    phone,
    cmFirebaseToken,
    point,
  ];
}
