import 'package:dartz/dartz.dart';
import 'package:fruit_hub/features/home/data_sources/remote/product_remote_data_source.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';

class ProductRepositoryImpl implements ProductRepository {
  // final ProductRemoteDataSource remoteDataSource;

  ApiHelper apiHelper = ApiHelper();

  // ProductRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<ProductsResponse> getRecommendedCombos() {
  //   return remoteDataSource.getRecommendedCombos();
  // }

  @override
  Future<Either<String, ProductModel>> getProductDetails({required int productId}) async {
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
}
