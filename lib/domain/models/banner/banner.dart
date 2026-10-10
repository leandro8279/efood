import 'package:equatable/equatable.dart';

class const Banner({
  required final int id,
  required final String title,
  required final String image,
  required final int productId,
  required final int status,
  required final String createdAt,
  required final String updatedAt,
  required final int categoryId,
}) extends Equatable {
  @override
  List<Object?> get props => [id, title, image, productId, status, createdAt, updatedAt, categoryId];
}
