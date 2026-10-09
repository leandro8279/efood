import 'package:efood/data/services/api/model/category/category_api_model.dart';
import 'package:efood/data/services/api/model/category/category_list_api_model.dart';
import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/category/category_page.dart';

extension CategoryApiModelMapper on CategoryApiModel {
  Category toDomain() => Category(
    id: id,
    name: name,
    parentId: parentId,
    position: position,
    status: status,
    priority: priority,
    createdAt: createdAt,
    updatedAt: updatedAt,
    image: image,
    bannerImage: bannerImage,
    children: children.map((child) => child.toDomain()).toList(growable: false),
  );
}

extension CategoryListApiModelMapper on CategoryListApiModel {
  CategoryPage toDomain() => CategoryPage(
    totalSize: totalSize,
    limit: limit,
    offset: offset,
    categories: categories.map((category) => category.toDomain()).toList(growable: false),
  );
}
