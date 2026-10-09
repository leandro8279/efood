import 'package:efood/data/services/api/model/profile/profile_api_model.dart';
import 'package:efood/domain/models/profile/profile.dart';

extension ProfileApiModelMapper on ProfileApiModel {
  Profile toDomain() => Profile(
    id: id,
    fName: fName,
    lName: lName,
    email: email,
    image: image,
    isPhoneVerified: isPhoneVerified,
    emailVerifiedAt: emailVerifiedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
    emailVerificationToken: emailVerificationToken,
    phone: phone,
    cmFirebaseToken: cmFirebaseToken,
    point: point,
  );
}
