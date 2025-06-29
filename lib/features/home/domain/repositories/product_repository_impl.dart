import 'package:dartz/dartz.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/core/network/api_response.dart';
import 'package:fruit_hub/core/network/end_points.dart';
import 'package:fruit_hub/features/home/data_sources/remote/product_remote_data_source.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource? remoteDataSource;
  final ApiHelper apiHelper;

  ProductRepositoryImpl({this.remoteDataSource, required this.apiHelper});

  @override
  Future<ProductsResponse> getRecommendedCombos() {
    return remoteDataSource!.getRecommendedCombos();
  }

  @override
  Future<ProductsResponse> getProductsByCategory(int categoryId) {
    return remoteDataSource!.getProductsByCategory(categoryId);
  }

  @override
  Future<Either<String, ProductModel>> getProductDetails({
    required int productId,
  }) async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: EndPoints.productDetails + productId.toString(),
        isProtected: true,
      );

      if (response.data != null) {
        ProductModel productModel = ProductModel.fromJson(
          response.data['data']['product'],
        );
        return Right(productModel);
      } else {
        return Left("Failed to load product details");
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }

  @override
  Future<ProductsResponse> searchProducts(String query) async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: EndPoints.searchProducts(query),
        isProtected: true,
      );

      if (response.data != null) {
        // Handle different response structures
        if (response.data['products'] != null) {
          // If products are directly in the response
          return ProductsResponse(
            products:
                (response.data['products'] as List)
                    .map((product) => ProductModel.fromJson(product))
                    .toList(),
            pagination: Pagination(
              currentPage: response.data['current_page'] ?? 1,
              lastPage: response.data['last_page'] ?? 1,
              perPage: response.data['per_page'] ?? 10,
              total: response.data['total'] ?? 0,
            ),
          );
        } else if (response.data['data'] != null &&
            response.data['data']['products'] != null) {
          // If products are nested under 'data'
          return ProductsResponse.fromJson(response.data['data']);
        } else {
          // Handle single product or empty response
          List<ProductModel> products = [];
          if (response.data['id'] != null) {
            products = [ProductModel.fromJson(response.data)];
          }
          return ProductsResponse(
            products: products,
            pagination: Pagination(
              currentPage: 1,
              lastPage: 1,
              perPage: products.length,
              total: products.length,
            ),
          );
        }
      } else {
        throw Exception("No data received from server");
      }
    } catch (e) {
      throw Exception("Search failed: ${e.toString()}");
    }
  }
}
