import 'package:equatable/equatable.dart';
import 'package:efood/domain/models/category/category.dart';

class const CategoryPage({
  required final int totalSize,
  required final int limit,
  required final int offset,
  required final List<Category> categories,
}) extends Equatable {
  @override
  List<Object?> get props => [totalSize, limit, offset, categories];
}
