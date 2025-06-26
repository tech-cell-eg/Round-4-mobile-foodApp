import '../models/product_model.dart';

abstract class ProductRepository {
  Future<ProductsResponse> getRecommendedCombos();
}
