import 'package:dartz/dartz.dart';
import 'package:fruit_hub/features/basket/data/repo/shopping_cart_repo.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../models/shopping_cart_model.dart';

class ShoppingCartRepoImplementation implements ShoppingCartRepo {
  // singleton
  static final ShoppingCartRepoImplementation _instance =
      ShoppingCartRepoImplementation._internal();
  factory ShoppingCartRepoImplementation() => _instance;
  ShoppingCartRepoImplementation._internal();

  ApiHelper apiHelper = ApiHelper();

  @override
  Future<Either<String, List<Item>>> getShoppingCart() async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: EndPoints.cart,
        isProtected: true,
      );

      if (response.status) {
        ShoppingCartModel shoppingCart = ShoppingCartModel.fromJson(
          response.data,
        );

        return Right(shoppingCart.items);
      } else {
        return Left("Failed to load shopping cart");
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }
}
