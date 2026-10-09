import 'package:equatable/equatable.dart';

class const Profile({
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
