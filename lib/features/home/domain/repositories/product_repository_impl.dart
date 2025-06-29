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

  ProductRepositoryImpl({
    this.remoteDataSource,
    required this.apiHelper,
  });

  @override
  Future<ProductsResponse> getRecommendedCombos() {
    return remoteDataSource!.getRecommendedCombos();
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
  Future<Either<String, String>> addToBasket({required int productId, required int quantity}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.cart,
        isProtected: true,
        data: {
          'product_id': productId,
          'quantity': quantity,
        }
      );

      if (response.status) {
        return Right(response.message);
      } else {
        return Left("Failed to add to basket: ${response.message}");
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }


}
