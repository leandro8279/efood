import 'package:efood/domain/models/product/product.dart';
import 'package:equatable/equatable.dart';

class const ProductList({
  required final int totalSize,
  required final int limit,
  required final int offset,
  required final List<Product> products,
}) extends Equatable {
  @override
  List<Object?> get props => [totalSize, limit, offset, products];
}
