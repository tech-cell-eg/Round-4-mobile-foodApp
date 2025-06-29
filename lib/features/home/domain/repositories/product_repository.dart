import 'package:dartz/dartz.dart';

import '../models/product_model.dart';

abstract class ProductRepository {
  Future<ProductsResponse> getRecommendedCombos();
  Future<Either<String, ProductModel>> getProductDetails({
    required int productId,
  });
}
