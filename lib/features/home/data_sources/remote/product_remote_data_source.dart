// product_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:fruit_hub/core/network/end_points.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponse> getRecommendedCombos();
  Future<ProductsResponse> getProductsByCategory(int categoryId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProductsResponse> getRecommendedCombos() async {
    final response = await dio.get(EndPoints.recommendedCombo);
    return ProductsResponse.fromJson(response.data['data']);
  }

  @override
  Future<ProductsResponse> getProductsByCategory(int categoryId) async {
    final response = await dio.get(
      '${EndPoints.baseUrl}/categories/$categoryId/products/',
    );
    return ProductsResponse.fromJson(response.data['data']);
  }
}
