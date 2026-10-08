// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_phone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPhoneRequest _$VerifyPhoneRequestFromJson(Map<String, dynamic> json) =>
    VerifyPhoneRequest(
      phone: json['phone'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VerifyPhoneRequestToJson(VerifyPhoneRequest instance) =>
    <String, dynamic>{'phone': instance.phone, 'token': instance.token};
