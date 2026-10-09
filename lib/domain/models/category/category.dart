import 'package:equatable/equatable.dart';

class const Category({
  required final int id,
  required final String name,
  required final int parentId,
  required final int position,
  required final int status,
  required final int priority,
  required final String createdAt,
  required final String updatedAt,
  required final String image,
  required final String? bannerImage,
  required final List<Category> children,
}) extends Equatable {
  @override
  List<Object?> get props => [
    id,
    name,
    parentId,
    position,
    status,
    priority,
    createdAt,
    updatedAt,
    image,
    bannerImage,
    children,
  ];
}
