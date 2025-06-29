import 'package:dartz/dartz.dart';

import '../models/product_model.dart';

abstract class ProductRepository {
  Future<ProductsResponse> getRecommendedCombos();
  Future<Either<String, ProductModel>> getProductDetails({
    required int productId,
  });
  Future<ProductsResponse> getProductsByCategory(int categoryId);
  Future<ProductsResponse> searchProducts(String query);
  Future<Either<String, String>> addToBasket({
    required int productId,
    required int quantity,
  });
}
