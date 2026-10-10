import 'package:efood/data/services/api/model/category/category_api_model.dart';
import 'package:efood/domain/models/category/category.dart';

extension CategoryApiModelMapper on CategoryApiModel {
  Category toDomain() => Category(
    id: id,
    name: name,
    parentId: parentId,
    position: position,
    status: status,
    image: image,
    bannerImage: bannerImage,
  );
}
