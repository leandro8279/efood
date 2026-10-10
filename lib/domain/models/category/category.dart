import 'package:equatable/equatable.dart';

class const Category({
  required final int id,
  required final String name,
  required final int parentId,
  required final int position,
  required final int status,
  required final String image,
  required final String? bannerImage,
}) extends Equatable {
  @override
  List<Object?> get props => [id, name, parentId, position, status, image, bannerImage];
}
