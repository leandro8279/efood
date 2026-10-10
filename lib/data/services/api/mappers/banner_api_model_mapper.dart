import 'package:efood/data/services/api/model/banner/banner_api_model.dart';
import 'package:efood/domain/models/banner/banner.dart';

extension BannerApiModelMapper on BannerApiModel {
  Banner toDomain() => Banner(
    id: id,
    title: title,
    image: image,
    productId: productId,
    status: status,
    categoryId: categoryId,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
