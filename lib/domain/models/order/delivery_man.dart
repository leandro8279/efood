import 'package:efood/domain/models/product/product.dart';
import 'package:equatable/equatable.dart';

class const DeliveryMan({
  required final int id,
  required final String fName,
  required final String lName,
  required final String phone,
  required final String email,
  required final String identityNumber,
  required final String identityType,
  required final String identityImage,
  required final String image,
  required final String password,
  required final String createdAt,
  required final String updatedAt,
  required final String authToken,
  required final String fcmToken,
  required final List<ProductRating> rating,
}) extends Equatable {
  @override
  List<Object?> get props => [
    id,
    fName,
    lName,
    phone,
    email,
    identityNumber,
    identityType,
    identityImage,
    image,
    password,
    createdAt,
    updatedAt,
    authToken,
    fcmToken,
    rating,
  ];
}
