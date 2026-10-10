// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileApiModel _$ProfileApiModelFromJson(Map<String, dynamic> json) =>
    ProfileApiModel(
      id: (json['id'] as num).toInt(),
      fName: json['f_name'] as String,
      lName: json['l_name'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      isPhoneVerified: (json['is_phone_verified'] as num).toInt(),
      emailVerifiedAt: json['email_verified_at'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      emailVerificationToken: json['email_verification_token'] as String,
      phone: json['phone'] as String,
      cmFirebaseToken: json['cm_firebase_token'] as String,
      point: (json['point'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProfileApiModelToJson(ProfileApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'f_name': instance.fName,
      'l_name': instance.lName,
      'email': instance.email,
      'image': instance.image,
      'is_phone_verified': instance.isPhoneVerified,
      'email_verified_at': instance.emailVerifiedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'email_verification_token': instance.emailVerificationToken,
      'phone': instance.phone,
      'cm_firebase_token': instance.cmFirebaseToken,
      'point': instance.point,
    };
